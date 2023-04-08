{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
}:

buildPythonPackage rec {
  pname = "async-timeout";
  version = "v4.0.2";  # Use main branch since we need llama

  src = fetchFromGitHub {
    owner = "aio-libs";
    repo = pname;
    rev = version;
    hash = "sha256-12WNL2XgF59XI03qiMvJBL2h6OY0/hw9L2hO7qqtlA0=";
  };
  
  format = "pyproject";

  buildInputs = [ setuptools ];

  doCheck = true;

  pythonImportsCheck = [ "async_timeout" ];

  meta = with lib; {
    description = ''
      asyncio-compatible timeout class
    '';
    homepage = "https://github.com/aio-libs/async-timeout";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
