{ lib
,buildPythonPackage
, fetchFromGitHub  
, numpy  
, openai
, cachetools
}:

buildPythonPackage rec {
  pname = "gptcache";
  version = "0.1.11";

  src = fetchFromGitHub {
    owner = "zilliztech";
    repo = "GPTCache";
    rev = "${version}";
    hash = "sha256-1qLF9EoQLhlRuTwHGtsD8RVCvIblZwl9pMqPT3ksgaQ=";
  };

  propagatedBuildInputs = [
    numpy
    openai
    cachetools
  ];

  pythonImportsCheck = [
    "gptcache"
  ];

  # The tests requires sentence-transformer and probably also internet.
  # Therefore disable it.
  doCheck = false;

  meta = with lib; {
    description = ''
      GPTCache is a library for creating semantic cache to store responses from LLM queries
    '';
    homepage = "https://github.com/zilliztech/GPTCache";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
