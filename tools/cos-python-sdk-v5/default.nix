{ lib, buildPythonPackage, pythonOlder, fetchFromGitHub, setuptools, xmltodict
, six, crcmod, pycryptodome, requests }:

buildPythonPackage rec {
  pname = "cos-python-sdk-v5";
  version = "1.9.33";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "tencentyun";
    repo = pname;
    rev = "V${version}";
    hash = "sha256-AHNvMC5l4/kagmjxVzaZKIRw62WLQdeN9qfBTTcfpyQ=";
  };

  build-system = [ setuptools ];

  dependencies = [ xmltodict six crcmod pycryptodome requests ];

  pythonImportsCheck = [ "qcloud_cos" ];

  meta = with lib; {
    description = "腾讯云 (Tencent Cloud) COSV5Python SDK";
    homepage = "https://github.com/tencentyun/cos-python-sdk-v5";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
