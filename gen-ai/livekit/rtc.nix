{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  requests,
  aiofiles,
  numpy,
  protobuf,
  types-protobuf,
}:

buildPythonPackage rec {
  pname = "livekit-rtc";
  version = "1.0.11";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "livekit";
    repo = "python-sdks";
    tag = "rtc-v${version}";
    hash = "sha256-VHlAct3iRh6nA2xPmnEmUxiSF+l70FbcIJbhVLUVK/g=";
  };

  pypaBuildFlags = [ "livekit-rtc" ];

  build-system = [ setuptools ];

  dependencies = [
    requests
    aiofiles
    numpy
    protobuf
    types-protobuf
  ];

  # doCheck = false; # no tests

  pythonImportsCheck = [ "livekit" ];

  meta = {
    description = "LiveKit real-time and server SDKs for Python";
    homepage = "https://github.com/livekit/python-sdks/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ breakds ];
    platforms = lib.platforms.all;
  };
}
