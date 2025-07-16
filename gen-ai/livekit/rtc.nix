{
  lib,
  stdenv,
  buildPythonPackage,
  fetchFromGitHub,
  fetchurl,
  autoPatchelfHook,
  setuptools,
  unzip,
  requests,
  aiofiles,
  numpy,
  protobuf,
  types-protobuf,
  system,
}:


let
  # See this link to decide the version
  #  https://github.com/livekit/rust-sdks/blob/ab99f24eb4f55fe0c32a462faf1d74c752ffd76d/Cargo.toml
  livekit-ffi-version = "0.12.28";

  platform = {
    "x86_64-linux" = "linux";
    "aarch64-linux" = "linux";
    "aarch64-darwin" = "macos";
  }."${system}";
  
  arch = {
    "x86_64-linux" = "x86_64";
    "aarch64-linux" = "arm64";
    "aarch64-darwin" = "arm64";
  }."${system}";

  livekit-ffi-hash = {
    "x86_64-linux" = "sha256-QrnIkKpiBnERnrXv7sKi/W9iW1Co7KRxwiJIctTRQKE=";
    "aarch64-darwin" = "1nh1z7mcyajk87z3gmdbdgrp8d1skd4q16b9dkykha3b7m0vib5x";
  }."${system}";
  
  livekit-ffi = fetchurl {
    url = "https://github.com/livekit/client-sdk-rust/releases/download/rust-sdks/livekit-ffi@${livekit-ffi-version}/ffi-${platform}-${arch}.zip";
    hash = livekit-ffi-hash;
  };

in buildPythonPackage rec {
  pname = "livekit-rtc";
  version = "1.0.11";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "livekit";
    repo = "python-sdks";
    tag = "rtc-v${version}";
    hash = "sha256-VHlAct3iRh6nA2xPmnEmUxiSF+l70FbcIJbhVLUVK/g=";
  };

  # This package requires downloading the prebuilt rust-sdk binary of
  # livekit-ffi and put it under resources directory. The `pyproject.toml` has a
  # hook to copy it to the final build.
  postPatch = ''
    pushd livekit-rtc/livekit/rtc/resources
    unzip "${livekit-ffi}"
    ls .
    popd
  '';

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  pypaBuildFlags = [ "livekit-rtc" ];

  build-system = [ setuptools ];

  dependencies = [
    requests
    aiofiles
    numpy
    protobuf
    types-protobuf
  ];

  pythonImportsCheck = [ "livekit" ];

  meta = {
    description = "LiveKit real-time and server SDKs for Python";
    homepage = "https://github.com/livekit/python-sdks/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ breakds ];
    platforms = lib.platforms.all;
  };
}
