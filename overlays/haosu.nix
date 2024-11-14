final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      sapien = python-final.callPackage ../pkgs/sapien {};
      maniskill = python-final.callPackage ../pkgs/maniskill {};

      pytorch-seed = python-final.callPackage ../pkgs/pytorch-seed {
        torch = python-final.torchWithCuda;
      };
      pytorch-kinematics = python-final.callPackage ../pkgs/pytorch-kinematics {
        torch = python-final.torchWithCuda;
      };
      arm-pytorch-utilities = python-final.callPackage ../pkgs/arm-pytorch-utilities {
        torch = python-final.torchWithCuda;
      };
      fast-kinematics = python-final.callPackage ../pkgs/fast-kinematics {
        torch = python-final.torchWithCuda;
      };
      toppra = python-final.callPackage ../pkgs/toppra {};
      mplib = python-final.callPackage ../pkgs/mplib {};
      stable-baselines3 = python-final.callPackage ../pkgs/stable-baselines3 {};

      tyro = python-final.callPackage ../pkgs/tyro {};
      docstring-parser = python-prev.docstring-parser.overrideAttrs rec {
        version = "0.16";
        src = final.fetchFromGitHub {
          owner = "rr-";
          repo = "docstring_parser";
          rev = "${version}";
          hash = "sha256-xwV+mgCOC/MyCqGELkJVqQ3p2g2yw/Ieomc7k0HMXms=";
        };
      };

      pybind-smart-holder = python-final.pybind11.overrideAttrs {
        src = final.fetchFromGitHub {
          owner = "pybind";
          repo = "pybind11";
          rev = "3b35ce475fa359abc31d979972f650c601d6158b";
          hash = "sha256-zgWTcgO0BvCOjFrNPrLTi0JXedhW2Oai1qwf5DA7e6A=";
        };
        postPatch = "";
      };
    })
  ];

  physx5-gpu = final.callPackage ../pkgs/physx5-gpu {};
  physx5 = final.callPackage ../pkgs/physx5 {};
  sapien-vulkan-2 = final.callPackage ../pkgs/sapien-vulkan-2 {};
  assimp-sapien = final.assimp.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "fbxiang";
      repo = "assimp";
      rev = "0ea31aa6734336dc1e62c6d9bde3e49b6d71b811";
      sha256 = "sha256-IqF46UQNGQ/EZJ/D0SsOqp+Tyn5oSNtunNx0lxaTRGE=";
    };
  };
  glm-sapien = final.glm.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "g-truc";
      repo = "glm";
      rev = "0.9.9.8";
      hash = "sha256-F//+3L5Ozrw6s7t4LrcUmO7sN30ZSESdrPAYX57zgr8=";
    };
  };
  openexr-sapien = final.openexr_3.overrideAttrs {
    postFixup = ''
      substituteInPlace $dev/include/OpenEXR/*.h \
        --replace-warn '#include <Imath' '#include <Imath/Imath' \
        --replace-warn '#include "Imath' '#include "Imath/Imath' \
        --replace-warn '#include <half.h' '#include <Imath/half.h'
    '';
    doCheck = false;
  };
  ompl = final.callPackage ../pkgs/ompl {};
}
