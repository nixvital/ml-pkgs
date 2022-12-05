# Warning: (deprecated) this package does not work with the updated
# version of gym. Please use ale-py instead.

# This packages the atari-py together with the Atari 2600 roms.

{ lib
, buildPythonPackage
, python
, fetchFromGitHub
, cmake
, numpy
, six
, nose2
, stdenv
, zlib
, unrar
, writeShellScriptBin
}:

let atari-roms = builtins.fetchurl {
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
  pname = "atari-py";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "openai";
    repo = "atari-py";
    rev = "b0117f704919ed4cbbd5addcec5ec1b0fb3bff99";
    sha256 = "sha256-RYLO1mja6QOQKhEs1pTHGZ+QzSUt5bZViajnkOEL0f8=";
  };

  propagatedBuildInputs = [ numpy six nose2 ];

  buildInputs = [
    zlib
  ];

  nativeBuildInputs = [
    cmake
  ];

  dontUseCmakeConfigure = true;  

  postFixup = let
    pkgPath = "$out/lib/python${python.pythonVersion}/site-packages/atari_py";
  in ''
    pushd ${pkgPath}
    #   mkdir roms_temp
    ${unrar}/bin/unrar x "${atari-roms}" roms_temp/
    head -n 10 ${pkgPath}/ale_interface/md5.txt
    ${import-atari-roms}/bin/import-atari-roms ${pkgPath} \
        ${pkgPath}/ale_interface/md5.txt \
        ${pkgPath}/roms_temp \
        ${pkgPath}/atari_roms
    rm -rf roms_temp/
    popd
  '';

  pythonImportsCheck = [ "atari_py" ];

  meta = with lib; {
    homepage = "https://github.com/openai/atari-py";
    description = ''
      A python interface for the Arcade Learning Environment
      that supports linux and Mac OS X
    '';
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
