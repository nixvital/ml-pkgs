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
    hash = "sha256-cOmOczsu/kCTac/GXSSHbZJ8DpmeOZy2+UH/98WLgMM=";
  };

  patches = [
    ./0001-Fix-Popen-call.patch
  ];

  nativeBuildInputs = [ python3Packages.cython ];

  buildInputs = with python3Packages; [
    setuptools
  ];

  propagatedBuildInputs = with python3Packages; [
    aim-ui
    aimrocks
    aimrecords
    cachetools
    click
    cryptography
    filelock
    numpy
    psutil
    restrictedpython
    tqdm
    aiofiles
    alembic
    fastapi
    jinja2
    pytz
    sqlalchemy
    uvicorn
    pillow
    packaging
    python-dateutil
    requests
    websockets
    boto3
  ];

  doCheck = false;

  meta = with lib; {
    description = ''
      An easy-to-use & supercharged open-source experiment tracker
    '';
    homepage = "https://aimstack.io/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
