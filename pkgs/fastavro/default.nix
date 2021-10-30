{ lib
, buildPythonPackage
, fetchPypi
, check-manifest
, coverage
, codecov
, cython
, flake8
, lz4
, numpy
, pytest
, pytestcov
, python
, python-snappy
, twine
, wheel
}:

# NOTE(breakds): This is already packaged at 21.11: https://github.com/NixOS/nixpkgs/blob/a0dbe47318bbab7559ffbfa7c4872a517833409f/pkgs/development/python-modules/fastavro/default.nix
buildPythonPackage rec {
  pname = "fastavro";
  version = "1.4.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-FvzIKESROASwXyhIGXK4UFgP8xA7SPNsAh07mQGfnj8=";
  };

  nativeBuildInputs = [ cython ];

  propagatedBuildInputs = [ lz4 python-snappy ];

  preBuild = ''
    FASTAVRO_USE_CYTHON=1 ${python.interpreter} setup.py build_ext -i
  '';

  checkInputs = [
    check-manifest
    codecov
    coverage
    flake8
    numpy
    pytest
    pytestcov
    twine
    wheel
  ];

  doCheck = false;

  meta = with lib; {
    description = "Fast Avro for Python";
    homepage = "https://github.com/fastavro/fastavro";
    license = licenses.mit;
    maintainers = [ maintainers.breakds ];
  };
}
