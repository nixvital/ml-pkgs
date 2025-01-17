{ lib, buildPythonPackage, fetchFromGitHub, setuptools-scm, interegular
, cloudpickle, datasets, diskcache, joblib, jsonschema, pyairports, pycountry
, pydantic, lark, nest-asyncio, numba, scipy, torch, transformers, airportsdata
, outlines-core, }:

buildPythonPackage rec {
  pname = "outlines";
  version = "0.1.11";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "outlines-dev";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-BBfsDZ3Q4wW7SCcpOu9WBzeHSBCHTukdlOf+CxUC3KE=";
  };

  build-system = [ setuptools-scm ];

  dependencies = [
    interegular
    cloudpickle
    datasets
    diskcache
    joblib
    jsonschema
    pydantic
    lark
    nest-asyncio
    numba
    scipy
    torch
    transformers
    pycountry
    pyairports
    airportsdata
    outlines-core
  ];

  checkPhase = ''
    export HOME=$(mktemp -d)
    python3 -c 'import outlines'
  '';

  meta = with lib; {
    description = "Structured text generation";
    homepage = "https://github.com/outlines-dev/outlines";
    license = licenses.asl20;
    maintainers = with maintainers; [ lach ];
  };
}
