{ stdenv
, lib
, buildPythonPackage
, fetchFromGitHub

# build-system
, cython
, setuptools
, pytest

# native dependencies
, rocksdb_6_23
}:

buildPythonPackage rec {
  pname = "aimrocks";
  version = "2024.04.24";

  src = fetchFromGitHub {
    owner = "aimhubio";
    repo = "aimrocks";
    rev = "a477b4e9976454c31992056cf13033bb7bc534cc";
    hash = "sha256-TZwaljcztzvZG8CceFdx7f2ZKNixRD0D4CLKlXIUGKY=";
  };

  AIM_DEP_DIR = "${rocksdb_6_23}";

  # setuptoolsBuildPhase needs dependencies to be passed through nativeBuildInputs
  nativeBuildInputs = [
    cython
    setuptools
  ];

  buildInputs = [
    rocksdb_6_23
  ];

  # tests are meant to be ran "in-place" in the same directory as src
  # doCheck = false;

  checkInputs = [
    pytest
  ];

  pythonImportsCheck = [
    "aimrocks"
  ];

  meta = with lib; {
    description = "python & cython bindings for RocksDB. Batteries included!";
    homepage = "https://github.com/aimhubio/aimrocks";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
