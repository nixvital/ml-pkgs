{ lib, buildPythonPackage, fetchFromGitHub, setuptools, pythonRelaxDepsHook
, onnxruntime, pillow, numpy, opencv4 }:

buildPythonPackage rec {
  pname = "ddddocr";
  version = "1.5.5";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "sml2h3";
    repo = pname;
    rev = "262b0173390f2fd58886be0ad7a48df68b660e81";
    hash = "sha256-MUejMU6fMTIgB/eQJ7b7Ku9hOoPHL/mSRhKjFiRQ9l0=";
  };

  nativeBuildInputs = [ setuptools pythonRelaxDepsHook ];

  propagatedBuildInputs = [ onnxruntime pillow numpy opencv4 ];

  pythonRemoveDeps = [ "opencv-python-headless" ];

  meta = with lib; {
    description = ''
      带带弟弟 通用验证码识别OCR
    '';
    homepage = "https://ddddocr.com/";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
