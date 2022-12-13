{ lib
, buildPythonPackage
, fetchPypi
, beautifulsoup4
, botocore
, scramp
, requests
, lxml
, packaging
, boto3
, pytz
, setuptools
}:

# TODO(breakds): Make this for other systems such as MacOSX and Windows.

buildPythonPackage rec {
  pname = "redshift-connector";
  version = "2.0.909";
  format = "wheel";

  src = builtins.fetchurl {
    url = https://files.pythonhosted.org/packages/24/3c/471f5f7d43f1ed1be87494010f466849fe2376acf8bab49d4b676f870cf1/redshift_connector-2.0.909-py3-none-any.whl;
    sha256 = "0hzl3m4qv6iv6jkmpq3hj3q2r14fyk21h1ww31ld4qgr59ff5c4z";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    beautifulsoup4
    botocore
    scramp
    requests
    lxml
    packaging
    boto3
    pytz
  ];

  meta = with lib; {
    description = ''
      Redshift Python Connector. It supports Python Database API
      Specification v2.0
    '';
    homepage = "https://github.com/aws/amazon-redshift-python-driver";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
