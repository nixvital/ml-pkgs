{ lib
, buildPythonPackage
, autoPatchelfHook
, fetchFromGitHub
, stdenv
, numpy
, py-glfw
, fasteners
, cffi
, cython
, imageio
, mujoco
}:

buildPythonPackage rec {
  pname = "mujoco-py";
  version = "2.1.2.14";
  format = "wheel";

  src = builtins.fetchurl {
    url = https://files.pythonhosted.org/packages/37/e5/e7504cb2ded511910c2a2e8f9c9e28af075850eb03a5c5a8daee5d7d9517/mujoco_py-2.1.2.14-py3-none-any.whl;
    sha256 = "07x7wgrpkf38dvzy8x1zfmkm9xk0gjk06cb6nc78lfhmq0dv9h1p";
  };

  propagatedBuildInputs = [
    numpy
    py-glfw
    fasteners
    cffi
    cython
    imageio
    mujoco
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  meta = with lib; {
    homepage = "https://github.com/openai/mujoco-py";
    description = ''
      MuJoCo is a physics engine for detailed, efficient rigid body
      simulations with contacts. mujoco-py allows using MuJoCo from
      Python 3.
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; (linux ++ darwin);
  };
}
