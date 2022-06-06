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
}:

# TODO(breakds): Make this for other systems such as MacOSX and Windows.

buildPythonPackage rec {
  pname = "redshift-connector";
  version = "2.0.907";
  format = "wheel";

  src = builtins.fetchurl {
    url = https://files.pythonhosted.org/packages/47/90/415b21f7765c9f51f0ced590f8d00494ebc90ec85f1568c3bda704b5e5b1/redshift_connector-2.0.907-py3-none-any.whl;
    sha256 = "0syapqa39lmzw12ckajb1m4qclahklyfihwx57lvfbnx2zvmvizh";
  };

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
