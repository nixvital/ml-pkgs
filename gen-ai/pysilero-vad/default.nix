{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,

  # tests
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "pysilero-vad";
  version = "3.0.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rhasspy";
    repo = "pysilero-vad";
    tag = "v${version}";
    hash = "sha256-DZjinW4jXsygJSUq3iNt82mbnVj7DN8hUxUDe1NkpHM=";
  };

  build-system = [ setuptools ];

  nativeCheckInputs = [ pytestCheckHook ];

  # Remove source directory so tests import from installed package
  # (the native extension is only in $out, not in source dir)
  preCheck = ''
    rm -rf pysilero_vad
  '';

  pythonImportsCheck = [ "pysilero_vad" ];

  meta = {
    description = "Pre-packaged voice activity detector using silero-vad";
    homepage = "https://github.com/rhasspy/pysilero-vad";
    changelog = "https://github.com/rhasspy/pysilero-vad/blob/${src.tag}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ breakds ];
  };
}
