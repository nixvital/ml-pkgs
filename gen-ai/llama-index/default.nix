{
  buildPythonPackage,
  hatchling,
  llama-index-agent-openai,
  llama-index-cli,
  llama-index-core,
  llama-index-embeddings-openai,
  llama-index-indices-managed-llama-cloud,
  llama-index-legacy,
  llama-index-llms-openai,
  llama-index-multi-modal-llms-openai,
  llama-index-program-openai,
  llama-index-question-gen-openai,
  llama-index-readers-file,
  llama-index-readers-llama-parse,
}:

buildPythonPackage {
  pname = "llama-index";

  inherit (llama-index-core) version src meta;

  pyproject = true;

  build-system = [ hatchling ];

  pythonRelaxDeps = [
    "llama-index-core"
    "llama-index-multi-modal-llms-openai"
  ];

  postPatch = ''
    if [ -f pyproject.toml ]; then
      # Or remove the entire [project.scripts] because it only contains
      # `llama-index-cli`, which will cause conflict with the actual `llama-index-cli` package.
      sed -i '/^\[project\.scripts\]$/,/^\[.*\]$/{/^\[project\.scripts\]$/d; /^\[.*\]$/!d;}' pyproject.toml
    fi
  '';

  dependencies = [
    llama-index-agent-openai
    llama-index-cli
    llama-index-core
    llama-index-embeddings-openai
    llama-index-indices-managed-llama-cloud
    llama-index-legacy
    llama-index-llms-openai
    llama-index-multi-modal-llms-openai
    llama-index-program-openai
    llama-index-question-gen-openai
    llama-index-readers-file
    llama-index-readers-llama-parse
  ];

  pythonImportsCheck = [ "llama_index" ];
  dontCheckRuntimeDeps = true;
}
