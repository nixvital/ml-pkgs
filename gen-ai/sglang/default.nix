{ lib
, buildPythonPackage
, fetchFromGitHub
, litellm
# , torch_memory_saver
, pillow
, numpy
, huggingface-hub
, openai
, jsonlines
, transformers
, psutil
, tqdm
, orjson
# , llguidance  # 25.04
, pyzmq
, anthropic
, pandas
, pydantic
# , xgrammar  # 25.04
, fastapi
, setuptools
, requests
, prometheus-client
, hf-transfer
, datasets
# , modelscope
, accelerate
, packaging
, uvloop
# , torchao
, peft
, matplotlib
, interegular
, multipart
, ninja
, uvicorn
, tiktoken
, setproctitle
# , flashinfer_python
, sentence-transformers
, ipython
, outlines
, aiohttp
}:

let
  pname = "sglang";
  version = "0.4.4";

in buildPythonPackage rec {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "sgl-project";
    repo = "sglang";
    rev = "v${version}";
    hash = null;
  };

  sourceRoot = "${src.name}/python";

  build-system = [
    setuptools
  ];

  dependencies = [
    aiohttp
    requests
    tqdm
    numpy
    ipython
    setproctitle
  ];

  optional-dependencies = {
    runtime-common = [
      pillow
      huggingface-hub
      transformers
      psutil
      orjson
      # llguidance
      pyzmq
      pydantic
      # xgrammar
      fastapi
      prometheus-client
      hf-transfer
      datasets
      # modelscope
      packaging
      uvloop
      # torchao
      interegular
      multipart
      ninja
      uvicorn
    ];
    openai = [ openai tiktoken ];
    anthropic = [ anthropic ];
    litellm = [ litellm ];
    # torch_memory_saver = [ torch_memory_saver ];
    test = [
      peft
      matplotlib
      jsonlines
      pandas
      accelerate
      sentence-transformers
    ];
  };

  pythonImportsCheck = [ "sglang" ];

  meta = with lib; {
    homepage = "https://github.com/sgl-project/sglang";
    description = "SGLang is yet another fast serving framework for large language models and vision language models.";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
