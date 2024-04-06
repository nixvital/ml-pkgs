{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, setuptools
, numpy
, tqdm
# , compress_pickle
# , compress_json
, scikit-image
, objaverse
, trimesh
, msgpack
, filelock
}:

buildPythonPackage rec {
  pname = "objathor";
  version = "0.0.4";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "allenai";
    repo = pname;
    rev = version;
    sha256 = "sha256-L/uMGvdkCAh97v3ChoKN3hlkDpiTbGmUZTwJPgb43Ok=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    numpy
    tqdm
    # compress_pickle
    # compress_json
    scikit-image
    objaverse
    trimesh
    msgpack
    filelock
    
  ];

  pythonImportsCheck = [ "objathor" ];

  meta = with lib; {
    description = ''
      Python package for importing and loading external assets into AI2THOR
    '';
    homepage = "https://github.com/allenai/objathor/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
