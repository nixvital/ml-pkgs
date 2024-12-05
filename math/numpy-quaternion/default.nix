# NOTE: this library requires numpy >= 2.0

{ lib, fetchFromGitHub, buildPythonPackage, numpy, scipy, numba, hatchling }:

buildPythonPackage rec {
  pname = "numpy-quaternion";
  version = "2024.0.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "moble";
    repo = "quaternion";
    rev = "v${version}";
    hash = "sha256-3UVqeiGcdsjQQpVRhcDBf1N0XJw+Xe/Pp+4lmGzl8ws=";
  };

  build-system = [ hatchling ];

  propagatedBuildInputs = [ numpy scipy numba ];

  pythonImportsCheck = [ "quaternion" ];

  meta = with lib; {
    homepage = "https://github.com/moble/quaternion";
    description = ''
      Add built-in support for quaternions to numpy
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
