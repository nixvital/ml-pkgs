{ lib
, buildPythonPackage
, fetchPypi
, pythonRelaxDepsHook
, isPy3k
, numpy
, pandas
, pg8000
, pyarrow
, pymysql
, redshift-connector
, poetry-core
, backoff
, jsonpath-ng
, requests-aws4auth
, openpyxl
}:

buildPythonPackage rec {
  pname = "awswrangler";
  version = "2.18.0";
  disabled = !isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-PTuIXySkw6DqGz/5qu+Syeip4rP4d/6fA0E2cbo5pIU=";
  };

  format = "pyproject";

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "pg8000"
  ];

  propagatedBuildInputs = [
    numpy
    pandas
    pg8000
    pyarrow
    pymysql
    redshift-connector
    poetry-core
    backoff
    jsonpath-ng
    requests-aws4auth
    openpyxl    
  ];

  doCheck = false;

  # preCheck = ''
  #   export HOME=$TMPDIR
  #   mkdir -p $HOME/.matplotlib
  #   echo "backend: ps" > $HOME/.matplotlib/matplotlibrc
  # '';

  # checkInputs = [ exdown pytestCheckHook ];
  # pythonImportsCheck = [ "dufte" ];

  meta = with lib; {
    broken = true;  # It requires opensearch-py, which does not exist yet.
    description = ''
      Pandas on AWS - Easy integration with Athena, Glue, Redshift,
      Timestream, QuickSight, Chime, CloudWatchLogs, DynamoDB, EMR,
      SecretManager, PostgreSQL, MySQL, SQLServer and S3 (Parquet,
      CSV, JSON and EXCEL)
    '';
    homepage = "https://github.com/awslabs/aws-data-wrangler";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
