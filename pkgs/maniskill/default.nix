{ lib
, fetchurl
, buildPythonPackage
, pythonRelaxDepsHook
, python
, stdenv
, autoPatchelfHook
, numpy
, scipy
, dacite
, gymnasium
, sapien
, h5py
, pyyaml
, tqdm
, gitpython
, tabulate
, transforms3d
, trimesh
, imageio
, imageio-ffmpeg
# , mplib
# , fast-kinematics
, ipython
# , pytorch-kineamtics
# , tyro
, huggingface-hub
}:


buildPythonPackage rec {
  pname = "maniskill";
  version = "3.0.0b9";

  src = assert python.isPy3; fetchurl {
    url = https://files.pythonhosted.org/packages/b0/8b/a5280e381c1adaf16f6f02463d432cef19e44e30d4704a0c858d1a35e181/mani_skill-3.0.0b9-py3-none-any.whl; 
    sha256 = "dc258ffbdcaf239261aa5f071951d9c082c506be62dde2ca6256cdfd2d0b45de";
  };

  propagatedBuildInputs = [
    numpy
    scipy
    dacite
    gymnasium
    sapien
    h5py
    pyyaml
    tqdm
    gitpython
    tabulate
    transforms3d
    trimesh
    imageio
    imageio-ffmpeg
    # mplib
    # fast-kinematics
    ipython
    # pytorch-kineamtics
    # tyro
    huggingface-hub
  ];

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  meta = with lib; {
    homepage = "https://github.com/haosulab/ManiSkill";
    description = ''
      ManiSkill3: A Unified Benchmark for Generalizable Manipulation Skills.
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
