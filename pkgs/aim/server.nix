{ lib
, python3Packages
, fetchFromGitHub
}:

python3Packages.buildPythonApplication rec {
  pname = "aim";
  version = "3.23.0";

  src = fetchFromGitHub {
    owner = "aimhubio";
    repo = "aim";
    rev = "v${version}";
  };

  buildInputs = with python3Packages; [
    setuptools
  ];

  propagatedBuildInputs = with python3Packages; [
    'aimrecords==0.0.7',
    'aimrocks==0.5.*',
    'cachetools>=4.0.0',
    'click>=7.0',
    'cryptography>=3.0',
    'filelock<4,>=3.3.0',
    'numpy<3,>=1.12.0',
    'psutil>=5.6.7',
    'RestrictedPython>=5.1',
    'tqdm>=4.20.0',
    'aiofiles>=0.5.0',
    'alembic<2,>=1.5.0',
    'fastapi<1,>=0.69.0',
    'jinja2<4,>=2.10.0',
    'pytz>=2019.1',
    'SQLAlchemy>=1.4.1',
    'uvicorn<1,>=0.12.0',
    'Pillow>=8.0.0',
    'packaging>=15.0',
    'python-dateutil',
    'requests',
    'websockets',
    'boto3',
  ];

  meta = with lib; {
    description = ''
      An easy-to-use & supercharged open-source experiment tracker
    '';
    homepage = "https://aimstack.io/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
