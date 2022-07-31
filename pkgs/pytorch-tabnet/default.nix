{ lib
, buildPythonPackage
, fetchFromGitHub
, numpy
, pytorch
, tqdm
, scikit-learn
, scipy
, poetry
}:

buildPythonPackage rec {
  pname = "pytorch-tabnet";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "dreamquark-ai";
    repo = "tabnet";
    rev = "v3.1.1";
    sha256 = "sha256-swHoLtwXWevhIPR4m8quxNGQaaKhN2R/FwwCPQbPij8=";
  };

  format = "pyproject";

  propagatedBuildInputs = [ poetry numpy pytorch tqdm scikit-learn scipy ];

  doCheck = true;

  meta = with lib; {
    description = ''
      PyTorch implementation of TabNet
    '';
    homepage = "https://github.com/dreamquark-ai/tabnet";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
