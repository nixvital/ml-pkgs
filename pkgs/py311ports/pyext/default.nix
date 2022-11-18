{ lib, buildPythonPackage, fetchFromGitHub }:

buildPythonPackage {
    pname = "pyext";
    version = "0.8";

    # Latest release not on Pypi or tagged since 2015
    src = ./.;

    # Has no test suite
    doCheck = false;

    meta = with lib; {
      description = "Simple Python extensions";
      homepage = "https://github.com/kirbyfan64/PyExt";
      license = licenses.mit;
      maintainers = with maintainers; [ edwtjo ];
    };
}
