{ lib
, gcc12Stdenv
, fetchzip
, autoPatchelfHook
}:

let
  stdenv = gcc12Stdenv;
in
stdenv.mkDerivation rec {
  pname = "physx5-gpu";
  version = "106.0-physx-5.4.1.patch0";

  src = fetchzip {
    url = "https://github.com/sapien-sim/physx-precompiled/releases/download/${version}/linux-so.zip";
    hash = "sha256-ApoOhIPxSsFnrzJ2ZeQ4Z2JhUVB1CFGp7uFnwhfDq6Y=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];

  installPhase = ''
    mkdir -p $out/lib
    cp libPhysXGpu_64.so $out/lib/
  '';

  meta = with lib; {
    description = "NVIDIA PhysX GPU library";
    homepage = "https://github.com/sapien-sim/physx-precompiled";
    license = licenses.unfreeRedistributable;
    platforms = platforms.linux;
  };
}
