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
  version = "2.0.905";
  format = "wheel";

  src = builtins.fetchurl {
    url = https://files.pythonhosted.org/packages/d9/6e/42c024a445da8ab057d9d16acc2add9d7a8f78e28f5b4a0e20afd6cf29c2/redshift_connector-2.0.905-py3-none-any.whl;
    sha256 = "0q6hlzj2kbn8fj2w93a1mgq0plvjf3cynqkld7ws71zvlp378w79";
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
