{ lib
, stdenv
, fetchFromGitHub
, cmake
, git
, pkg-config
, cudatoolkit
, vulkan-headers
, vulkan-loader
, vulkan-validation-layers
, glm
, assimp
, spdlog
, fmt
, glfw
, ktx-tools
, glslang
, spirv-cross
, spirv-tools
, spirv-headers
, imath
, openexr_3
, openvr
, openimagedenoise
, xorg
, zlib
, minizip
, cudaPackages
, cudaSupport ? true
}:
let
  openexr = openexr_3.overrideAttrs {
    postFixup = ''
      substituteInPlace $dev/include/OpenEXR/*.h \
        --replace-warn '#include <Imath' '#include <Imath/Imath' \
        --replace-warn '#include "Imath' '#include "Imath/Imath' \
        --replace-warn '#include <half.h' '#include <Imath/half.h'
    '';
    doCheck = false;
  };
  assimp-sapien = assimp.overrideAttrs {
    src = fetchFromGitHub {
      owner = "fbxiang";
      repo = "assimp";
      rev = "0ea31aa6734336dc1e62c6d9bde3e49b6d71b811";
      sha256 = "sha256-IqF46UQNGQ/EZJ/D0SsOqp+Tyn5oSNtunNx0lxaTRGE=";
    };
  };
  glm-sapien = glm.overrideAttrs {
    src = fetchFromGitHub {
      owner = "g-truc";
      repo = "glm";
      rev = "0.9.9.8";
      hash = "sha256-F//+3L5Ozrw6s7t4LrcUmO7sN30ZSESdrPAYX57zgr8=";
    };
  };
  imgui-src = fetchFromGitHub {
    owner = "ocornut";
    repo = "imgui";
    rev = "ef07ddf087c879baff8c0cac0ff1f40b7f0f060c";
    sha256 = "sha256-/49/TlpJLZQRaSdhZqdB3zGZxt2H2auxpg5s8ybhgdw=";
  };
  imguizmo-src = fetchFromGitHub {
    owner = "CedricGuillemet";
    repo = "ImGuizmo";
    rev = "1.83";
    sha256 = "sha256-YAsfuw4blRIQs/Ev+tDBfqfO5ffX8xsQYMX1bU1y3JM=";
  };
  imguifiledialog-src = fetchFromGitHub {
    owner = "aiekick";
    repo = "ImGuiFileDialog";
    rev = "v0.6.5";
    sha256 = "sha256-UnhWWUu2Eo+gvhLZJCTq+XzefRcqOAbLRSSUZaO7nzs=";
  };
in
stdenv.mkDerivation rec {
  pname = "sapien-vulkan-2";
  version = "47cca1405d3315553a0eee8d3377adc687bf9592";

  src = fetchFromGitHub {
    owner = "haosulab";
    repo = pname;
    rev = version;
    sha256 = "sha256-9otDhQTQI1heoQdSZuWykbExoCnPuS8WrSTFHD9wKQU=";
  };

  nativeBuildInputs = [
    cmake
    cudatoolkit
    pkg-config
  ];

  patches = [
    ./remove_includes.patch
    ./imgui_cmake.patch
    ./logger_fixes.patch
  ];

  postPatch = ''
    substituteInPlace app/main.cpp src/core/context.cpp src/core/physical_device.cpp src/core/instance.cpp src/renderer/gui.cpp \
      --replace-fail '#include <GLFW/glfw3.h>' '#include <${vulkan-headers}/include/vulkan/vulkan.h>
    #include <GLFW/glfw3.h>'

    substituteInPlace src/core/device.cpp src/core/instance.cpp src/renderer/vr.cpp \
      --replace-fail '#include <openvr.h>' '#include <openvr/openvr.h>'

    substituteInPlace src/common/image.cpp \
      --replace-fail '#include <Imf' '#include <OpenEXR/Imf'

    substituteInPlace src/shader/reflect.h \
      --replace-fail '#include <spirv_cross.hpp>' '#include <spirv_cross/spirv_cross.hpp>'

    substituteInPlace src/shader/glsl_compiler.cpp \
      --replace-fail '#include <SPIRV' '#include <glslang/SPIRV'
  '';

  buildInputs = [
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    glm-sapien
    assimp-sapien.dev
    spdlog.dev
    fmt.dev
    glfw
    ktx-tools
    glslang

    cudatoolkit

    spirv-tools
    spirv-cross
    spirv-headers

    openexr
    openexr.dev
    openvr
    # TODO: make sure we need this
    openimagedenoise
    zlib

    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
  ];

  propagatedBuildInputs = [
    vulkan-headers
    vulkan-loader
  ];

  cmakeFlags = [
    # "-DSVULKAN2_SHARED=ON"
    # "-DSVULKAN2_PROFILE=OFF"
    # "-DSVULKAN2_BUILD_TEST=OFF"
    # "-DSVULKAN2_CUDA_INTEROP=ON"
    "-Dimgui_SOURCE_DIR=${imgui-src}"
    "-Dimguizmo_SOURCE_DIR=${imguizmo-src}"
    "-Dimguifiledialog_SOURCE_DIR=${imguifiledialog-src}"
  ];

  meta = with lib; {
    description = "Rendering library for SAPIEN.";
    homepage = "https://github.com/haosulab/sapien-vulkan-2";
  };
}
