{ stdenv
, fetchzip
, fetchurl
, lib
}:

stdenv.mkDerivation rec {
  pname = "physx5";
  version = "106.0-physx-5.4.1.patch0";

  src = fetchzip {
    url = "https://github.com/sapien-sim/physx-precompiled/releases/download/${version}/linux-release.zip";
    stripRoot = false;
    hash = "sha256-805p57c4FFqBVfu2QFu3aX/86KdjhIp/vxveMGXTlEM=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out/
  '';

  meta = with lib; {
    description = "NVIDIA PhysX precompiled libraries";
    homepage = "https://github.com/sapien-sim/physx-precompiled";
    license = licenses.unfreeRedistributable;
    platforms = platforms.linux;
  };
}
