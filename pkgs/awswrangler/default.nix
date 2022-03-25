{ lib
, buildPythonPackage
, fetchPypi
, isPy3k
, numpy
, pandas
, pg8000
, pyarrow
, pymysql
, redshift-connector
, poetry
}:

buildPythonPackage rec {
  pname = "awswrangler";
  version = "2.14.0";
  disabled = !isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-7DoCemudNHoaOuBJQAVhUfI8thz72DjQow9+ogtMg0E=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    numpy
    pandas
    pg8000
    pyarrow
    pymysql
    redshift-connector
    poetry
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
