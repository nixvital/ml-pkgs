{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
}:

let pname = "magicattr";
    version = "2022.02.18";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "frmdstryr";
    repo = pname;
    rev = "15ae93def3693661066624c9d760b26f6e205199";
    hash = "sha256-FJtWU5AuunZbdlndGdfD1c9/0s7oRdoTi202pWjuAd8=";
  };

  build-system = [ setuptools ];

  meta = with lib; {
    description = ''
      A getattr and setattr that works on nested objects, lists,
      dicts, and any combination thereof without resorting to eval
    '';
    homepage = "https://github.com/frmdstryr/magicattr";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
