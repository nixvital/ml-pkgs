{ lib
, buildPythonPackage
, fetchFromGitHub
, absl-py
, numpy
, dm-tree
, pytest
}:

buildPythonPackage rec {
  pname = "dm-env";
  version = "1.5";

  src = fetchFromGitHub {
    owner = "deepmind";
    repo = "dm_env";
    rev = "v${version}";
    hash = "sha256-aEudcqmrLquZ9XvK/7pjyLvN/nDIeuYFQjdD1Cyh3Us=";
  };

  propagatedBuildInputs = [
    absl-py
    numpy
    dm-tree
  ];

  pythonImportsCheck = [
    "dm_env"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/deepmind/dm_env";
    description = ''
      A Python interface for reinforcement learning environments
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
