{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  setuptools,
  openai,
  tenacity,
  python-dotenv,
  pandas,
  platformdirs,
  datasets,
  diskcache,
  graphviz,
  gdown,
  litellm,
  pillow,
  httpx,
}:

let pname = "textgrad";
    version = "0.1.6";

in buildPythonPackage {
  inherit pname version;
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "zou-group";
    repo = "textgrad";
    rev = "v${version}";
    hash = "sha256-QJJYtL7okmqAQezNUk4yT35JS2WPmwCapCBlm/yxX6w=";
  };

  build-system = [ setuptools ];

  dependencies = [
    openai
    tenacity
    python-dotenv
    pandas
    platformdirs
    datasets
    diskcache
    graphviz
    gdown
    litellm
    pillow
    httpx
  ];

  pythonImportsCheck = [ "textgrad" ];

  meta = with lib; {
    description = ''
      TextGrad: Automatic "Differentiation" via Text -- using large language
      models to backpropagate textual gradients
    '';
    homepage = "https://textgrad.com/";
    license = licenses.mit;
    maintainers = with maintainers; [ braekds ];
  };
}
