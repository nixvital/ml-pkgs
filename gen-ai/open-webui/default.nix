{ lib, buildNpmPackage, fetchFromGitHub, python311, nixosTests, }:
let
  pname = "open-webui";
  version = "0.4.8";

  src = fetchFromGitHub {
    owner = "open-webui";
    repo = "open-webui";
    rev = "refs/tags/v${version}";
    hash = "sha256-9N/t8hxODM6Dk/eMKS26/2Sh1lJVkq9pNkPcEtbXqb4=";
  };

  frontend = buildNpmPackage {
    inherit pname version src;

    npmDepsHash = "sha256-ThOGBurFjndBZcdpiGugdXpv1YCwCN7s3l2JjSk/hY0=";

    # Disabling `pyodide:fetch` as it downloads packages during `buildPhase`
    # Until this is solved, running python packages from the browser will not work.
    postPatch = ''
      substituteInPlace package.json \
        --replace-fail "npm run pyodide:fetch && vite build" "vite build"
    '';

    env.CYPRESS_INSTALL_BINARY =
      "0"; # disallow cypress from downloading binaries in sandbox
    env.ONNXRUNTIME_NODE_INSTALL_CUDA = "skip";

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share
      cp -a build $out/share/open-webui

      runHook postInstall
    '';
  };
in python311.pkgs.buildPythonApplication rec {
  inherit pname version src;
  pyproject = true;

  # Not force-including the frontend build directory as frontend is managed by the `frontend` derivation above.
  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail ', build = "open_webui/frontend"' ""
  '';

  env.HATCH_BUILD_NO_HOOKS = true;

  pythonRelaxDeps = true;

  pythonRemoveDeps = [ "docker" "pytest" "pytest-docker" ];

  dependencies = with python311.pkgs; [
    aiohttp
    alembic
    anthropic
    apscheduler
    argon2-cffi
    async-timeout
    authlib
    bcrypt
    beautifulsoup4
    black
    boto3
    chromadb
    colbert-ai
    docx2txt
    duckduckgo-search
    einops
    extract-msg
    fake-useragent
    fastapi
    faster-whisper
    flask
    flask-cors
    fpdf2
    ftfy
    qdrant-client
    google-generativeai
    googleapis-common-protos
    langchain
    langchain-chroma
    langchain-community
    langfuse
    markdown
    nltk
    openai
    opencv-python-headless
    openpyxl
    pandas
    passlib
    peewee
    peewee-migrate
    psutil
    psycopg2-binary
    pydub
    pyjwt
    pymdown-extensions
    pymilvus
    pymongo
    pymysql
    pypandoc
    pypdf
    python-dotenv
    python-jose
    python-multipart
    python-pptx
    python-socketio
    pytube
    pyxlsb
    rank-bm25
    rapidocr-onnxruntime
    redis
    requests
    sentence-transformers
    tiktoken
    unstructured
    uvicorn
    validators
    xhtml2pdf
    xlrd
    youtube-transcript-api
    aiocache
    aiofiles
    ldap3
    opensearch-py
    pgvector
    soundfile
  ];

  build-system = with python311.pkgs; [ hatchling ];

  pythonImportsCheck = [ "open_webui" ];

  makeWrapperArgs = [ "--set FRONTEND_BUILD_DIR ${frontend}/share/open-webui" ];

  passthru.tests = { inherit (nixosTests) open-webui; };

  meta = {
    description = "Comprehensive suite for LLMs with a user-friendly WebUI";
    homepage = "https://github.com/open-webui/open-webui";
    changelog =
      "https://github.com/open-webui/open-webui/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ shivaraj-bh ];
    mainProgram = "open-webui";
  };
}
