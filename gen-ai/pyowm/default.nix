{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  geojson,
  pysocks,
  pythonOlder,
  requests,
  setuptools,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "pyowm";
  # This is to include a specific update about using 3.0 API of openweathermap
  # instead of 2.5, because 2.5 reaches EOL on 2024.11. Without this update,
  # pyowm will complaint about "Invalid API Key".
  version = "2024.11.08";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "csparpa";
    repo = "pyowm";
    rev = "dcef9c5b81ff8a8ba5b3745b2b8b4b3ae4f9b80e";
    hash = "sha256-EcGBC/RC636BiYfCNvBk6ttbIbavZmRYlWV8/oN8Hpo=";
  };

  pythonRelaxDeps = [ "geojson" ];

  build-system = [ setuptools ];

  dependencies = [
    geojson
    pysocks
    requests
    setuptools
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  # Run only tests which don't require network access
  pytestFlagsArray = [ "tests/unit" ];

  pythonImportsCheck = [ "pyowm" ];

  meta = with lib; {
    description = "Python wrapper around the OpenWeatherMap web API";
    homepage = "https://pyowm.readthedocs.io/";
    changelog = "https://github.com/csparpa/pyowm/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
