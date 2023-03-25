{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, xmltodict
, more-itertools
, jaraco_context
}:

buildPythonPackage rec {
  pname = "wolframalpha";
  version = "2023.02.22";

  src = fetchFromGitHub {
    owner = "jaraco";
    repo = pname;
    rev = "a94fff7817df248c3ffe30ba59aea5919167c2da";
    hash = "sha256-O4sB94bctekSm/wBns2+mx1oNjyz1I4tWN7DcgVZKoI=";
  };

  format = "pyproject";

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    xmltodict
    more-itertools
    jaraco_context
  ];

  doCheck = true;

  pythonImportsCheck = [ "wolframalpha" ];

  meta = with lib; {
    description = ''
      Python Client built against the Wolfram|Alpha v2.0 API
    '';
    homepage = "https://github.com/jaraco/wolframalpha";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
