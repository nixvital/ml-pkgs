{ lib
, stdenv
, buildPythonPackage
, python
, pytorch
, torchvision
, numpy
, pyyaml
, pillow
, imageio
, pybind11
, autoPatchelfHook
, libGLU
}:

buildPythonPackage rec {
  pname = "isaac-gym";
  version = "preview4";

  src = builtins.fetchurl {
    url = https://extorage.breakds.org/isaac_gym/IsaacGym_Preview_4_Package.tar.gz;
    sha256 = "13yv9waw7nvwzszpw61pgqa6i56mv09p7723dwsipfa426n7f7f5";
  };

  sourceRoot = "isaacgym/python";

  postPatch = ''
    # We need to ask it to collect src for the JIT. The original setup.py is wrong.
    substituteInPlace setup.py --replace "package_files = []" \
        "package_files = collect_files('isaacgym/_bindings/src')"
    # ninja should be a non-python dependency.
    substituteInPlace setup.py --replace "\"ninja\"," ""
  '';

  # ---------- Handling patchelf of the shared objects ----------

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    libGLU
    pytorch.cudaPackages.cudatoolkit.lib
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libcuda.so.1"
    "libpython3.7m.so.1.0"
    "libRobotImp.so"
    "usdSchemaExamples.so"
  ];

  # ---------- Dependencies ----------

  propagatedBuildInputs = [
    pytorch
    torchvision
    numpy
    pyyaml
    pillow
    imageio
    pybind11  # Needed for JIT build of the gymtorch
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://developer.nvidia.com/isaac-gym";
    description = ''
      Isaac Gym is NVIDIA’s prototype physics simulation environment
      for end-to-end GPU accelerated reinforcement learning research.
    '';
    license = licenses.unfreeRedistributable;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
    broken = !(builtins.elem python.pythonVersion ["3.8"]);
  };
}
