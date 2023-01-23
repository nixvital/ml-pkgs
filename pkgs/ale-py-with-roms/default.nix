{ lib
, stdenv
, buildPythonPackage
, fetchurl
, writeShellScriptBin
, python
, unrar
, autoPatchelfHook
, numpy
, typing-extensions
, importlib-metadata
, importlib-resources
}:

let pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;
    version = "0.8.0";
    srcs = import ./binary-hashes.nix version;
    unsupported = throw "Unsupported system";

    atari-roms = fetchurl {
      url = "https://extorage.breakds.org/atari/Roms.rar";
      sha256 = "0f60333knxzzl4m3jgi67kbpyw6vr7j8vmbc9v9cmrdshbrm5481";
    };

    # The following script is used to install ROMS in to atari-py.
    #
    # Inside atari-py there is a md5.txt with all the md5 hashes of
    # the roms (.bin files) that needs to be installed.
    #
    # This is done by downloading the ROMs in atari-roms (see above)
    # and run this script.
    import-atari-roms = writeShellScriptBin "import-atari-roms" ''
      MD5_FILE=$2
      ROM_DIRECTORY=$3
      TARGET_DIRECTORY=$4

      # Step 1 - Construct the hash -> bin file map

      declare -A bin_hash_map

      if [ ! -e ''${MD5_FILE} ]; then
          echo "[ERROR] ''${MD5_FILE} does not exist!"
          exit 125
      fi

      if [ ! -d ''${ROM_DIRECTORY} ]; then
          echo "[ERROR] ''${ROM_DIRECTORY} does not exist!"
          exit 125
      fi

      echo "Constructing .bin file and hash mapping from ''${MD5_FILE}"

      let entry_count=0

      while IFS=" " read -r hash fname; do
          if [ ''${#hash} == 32 ]; then
              bin_hash_map[''${hash}]=''${fname}
              let entry_count++
          fi
      done < ''${MD5_FILE}

      echo "Finished reading the md5 list, found ''${entry_count} entries."
      # Step 2 - Copy the matched bin files
      ORIGINAL_IFS="$IFS"
      IFS=$'\n' # Temporarily override IFS to be the newline
      for f in $(find ''${ROM_DIRECTORY} -type f -name "*.bin"); do
          md5=$(md5sum "$f" | cut -c 1-32)
          bin_file=''${bin_hash_map[$md5]-NOMATCH}
          if [ ''${bin_file} != "NOMATCH" ]; then
              dest="''${TARGET_DIRECTORY}/''${bin_file}"
              cp "$f" "$dest"
              echo "Copied matched file ($f) to ($dest)"
          fi
      done
      IFS="$ORIGINAL_IFS"
    '';

in buildPythonPackage rec {
  pname = "ale-py";
  inherit version;
  format = "wheel";

  src = fetchurl srcs."${stdenv.system}-${pyVerNoDot}" or unsupported;

  propagatedBuildInputs = [
    numpy
    typing-extensions
    importlib-metadata
    importlib-resources
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  pythonImportsCheck = [ "ale_py" ];

  postFixup = let
    pythonName = "python${python.pythonVersion}";
    pkgPath = "$out/lib/${pythonName}/site-packages/ale_py";
  in ''
    pushd ${pkgPath}
    mkdir roms_temp
    ${unrar}/bin/unrar x "${atari-roms}" roms_temp/
    ${import-atari-roms}/bin/import-atari-roms ${pkgPath} \
        ${./roms_md5.txt} \
        ${pkgPath}/roms_temp \
        ${pkgPath}/roms
    rm -rf roms_temp/
    popd
  '';


  meta = with lib; {
    description = ''
      The Arcade Learning Environment (ALE) -- a platform for AI research.
    '';
    homepage = "https://github.com/mgbellemare/Arcade-Learning-Environment";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ breakds ];
  };
}
