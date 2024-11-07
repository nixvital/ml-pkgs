{ stdenv, fetchzip, lib, libgcc }:

stdenv.mkDerivation rec {
  pname = "physx5-gpu";
  version = "105.1-physx-5.3.1.patch0";

  src = fetchzip {
    url = "https://github.com/sapien-sim/physx-precompiled/releases/download/${version}/linux-so.zip";
    sha256 = "sha256-oGHm1N9MNfHpeWCOyMNR/gNo3fqlpo7EeDsHaVWva5g=";
  };

  installPhase = ''
    mkdir -p $out/lib
    cp libPhysXGpu_64.so $out/lib/
  '';

  meta = with lib; {
    description = "NVIDIA PhysX GPU library";
    homepage = "https://github.com/sapien-sim/physx-precompiled";
    # license = licenses.unfreeRedistributable;
    platforms = platforms.linux;
  };
}
