  { stdenv
  , fetchzip
  , fetchurl
  , lib 
  }:

  stdenv.mkDerivation rec {
    pname = "physx5";
    version = "105.1-physx-5.3.1.patch0";

    src = fetchzip {
      url = "https://github.com/sapien-sim/physx-precompiled/releases/download/${version}/linux-release.zip";
      sha256 = "sha256-HyMDwRchF7EgD3mnGfALDSikz0sMQrWdGEjowwNqEX8=";
      stripRoot = false;
    };

    installPhase = ''
      mkdir -p $out
      cp -r * $out/
    '';

    meta = with lib; {
      description = "NVIDIA PhysX precompiled libraries";
      homepage = "https://github.com/sapien-sim/physx-precompiled";
      # license = licenses.unfreeRedistributable;
      platforms = platforms.linux;
    };
  }
