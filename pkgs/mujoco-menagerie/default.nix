{ lib
, buildPythonPackage
, fetchFromGitHub
, python
, poetry
}:

let mujoco-menagerie-models = fetchFromGitHub {
      owner = "deepmind";
      repo = "mujoco_menagerie";
      rev = "990936d7cb4c0eb9c5843b0963633ea2d0b42b91";  # 2022.12.16
      hash = "sha256-zJTbe013Si9qt2ymWqWg067xm5JQ43vl/Iwv77E5nrk=";
    };

in buildPythonPackage rec {
  pname = "mujoco-menagerie";
  version = "1.0.0";

  src = ./.;
  
  format = "pyproject";

  buildInputs = [
    poetry
  ];

  postFixup = let
    pkgPath = "$out/lib/python${python.pythonVersion}/site-packages/mujoco_menagerie";
  in ''
    ln -s ${mujoco-menagerie-models}/anybotics_anymal_b ${pkgPath}
    ln -s ${mujoco-menagerie-models}/anybotics_anymal_c ${pkgPath}
    ln -s ${mujoco-menagerie-models}/agility_cassie ${pkgPath}
    ln -s ${mujoco-menagerie-models}/unitree_a1 ${pkgPath}
    ln -s ${mujoco-menagerie-models}/frank_emika_panda ${pkgPath}
    ln -s ${mujoco-menagerie-models}/universal_robots_ur5e ${pkgPath}
  '';

  doCheck = false;

  meta = with lib; {
    description = ''
      Wrapper of Deepmind's high-quality models for the MuJoCo physics engine.
    '';
    homepage = "https://github.com/eleurent/highway-env";
    license = licenses.unfree;  # There are many of different licenses.
    maintainers = with maintainers; [ breakds ];
  };
}
