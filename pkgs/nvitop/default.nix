{ lib
, buildPythonApplication
, buildPythonPackage
, fetchPypi
, fetchFromGitHub
, psutil
, cachetools
, termcolor }:

let nvidia-ml-py = buildPythonPackage rec {
      pname = "nvidia-ml-py";
      version = "11.495.46";

      src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-j2jhrydHVgZ2Msfht5+xqTqN3fHgSFH8yus0rfpZliU=";
      };

      meta = with lib; {
        description = ''
          Python Bindings for the NVIDIA Management Library
        '';
      };
    };

in buildPythonApplication rec {
  pname = "nvitop";
  version = "0.6.2";

  src = fetchFromGitHub {
    owner = "XuehaiPan";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-PZrJB/sTY4YwFpMkZwoenzLEIu5Az207iGK1nyY8qOQ=";
  };

  propagatedBuildInputs = [ psutil cachetools termcolor nvidia-ml-py ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/XuehaiPan/nvitop";
    description = ''
      An interactive NVIDIA-GPU process viewer, the one-stop solution
      for GPU process manage ment
    '';
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
