{ lib
, buildPythonPackage
, fetchFromGitHub
, freetype-py
, imageio
, networkx
, numpy
, pillow
, pyglet  # TODO(breakds): May need to fix at 1.4.0a1
, pyopengl
, pyopengl-accelerate
, six
, trimesh
, scipy
}:

buildPythonPackage rec {
  pname = "pyrender";
  version = "2022.04.30";

  src = fetchFromGitHub {
    owner = "mmatl";
    repo = "pyrender";
    rev = "a59963ef890891656fd17c90e12d663233dcaa99";
    sha256 = "sha256-q3rBiCbz28ASOc77PEVFr+qOj/CnHuv3t9XvprP7T5A=";
  };

  propagatedBuildInputs = [
    freetype-py
    imageio
    networkx
    numpy
    pillow
    pyglet
    pyopengl
    pyopengl-accelerate
    six
    trimesh
    scipy
  ];

  pythonImportsCheck = [ "pyrender" ];

  meta = with lib; {
    homepage = "https://github.com/mmatl/pyrender";
    description = ''
      Easy-to-use glTF 2.0-compliant OpenGL renderer for visualization of 3D scenes
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
