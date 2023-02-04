{ lib
, fetchFromGitHub
, buildPythonPackage
, cython
, numpy
, octomap
, fcl
, eigen
, libccd
}:

buildPythonPackage rec {
  pname = "python-fcl";
  version = "0.7.0.4";

  src = fetchFromGitHub {
    owner = "BerkeleyAutomation";
    repo = "python-fcl";
    rev = "v${version}";
    hash = "sha256-JhyxNb5rdWdGmjSbUWX69Sr2xwFagChDcQ4jMgW6zIo=";
  };

  patches = [
    ./eigen_fix.patch
  ];

  propagatedBuildInputs = [
    numpy
  ];

  buildInputs = [
    octomap
    fcl
    eigen
    libccd
  ];

  nativeBuildInputs = [
    cython
  ];

  pythonImportsCheck = [ "fcl" ];

  preBuild = ''
    export EIGEN3_INCLUDE_DIR=${eigen}/include/eigen3
  '';

  meta = with lib; {
    homepage = "https://github.com/BerkeleyAutomation/python-fcl";
    description = ''
      Python binding of FCL library    
    '';
    license = licenses.bsd3;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
