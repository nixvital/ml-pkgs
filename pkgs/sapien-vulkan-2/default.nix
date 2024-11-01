{ stdenv
, cmake
, pkg-config
, cudatoolkit
, vulkan-headers
, vulkan-loader
, glm
, assimp
, spdlog
, glfw
, ktx-tools
, glslang
, spirv-cross
, imgui
, openexr
, openvr
, openimagedenoise
, xorg
, zlib
, cudaSupport ? true
}:

stdenv.mkDerivation rec {
  pname = "sapien-vulkan-2";
  version = "47cca1405d3315553a0eee8d3377adc687bf9592";

  src = fetchFromGitHub {
    owner = "haosulab";
    repo = pname;
    rev = version;
    sha256 = "";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    vulkan-headers
    vulkan-loader
    glm
    assimp
    spdlog
    glfw
    ktx-tools
    glslang
    spirv-cross
    imgui
    openexr.overrideAttrs { version = "3.2.1"; }
    openvr
    openimagedenoise
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    zlib
  ];

  # Set environment variables for CUDA and CMake
  preConfigure = ''
    export CUDA_PATH=${cuda.dev}
    export CMAKE_PREFIX_PATH="${stdenv.lib.makeSearchPath "cmake" [
      vulkan-headers
      glm
      assimp
      spdlog
      glfw
      ktx-tools
      glslang
      spirv-cross
      imgui
      openexr
      openvr
      openimagedenoise
    ]}"
  '';

  # Pass options to CMake
  cmakeFlags = [
    "-DCMAKE_CXX_STANDARD=20"
    "-DSVULKAN2_SHARED=ON"
    "-DSVULKAN2_PROFILE=OFF"
    "-DSVULKAN2_BUILD_TEST=OFF"
    "-DSVULKAN2_CUDA_INTEROP=ON"
  ];

  NIX_CFLAGS_COMPILE = [ "-std=c++20" ];

  meta = with stdenv.lib; {
    description = "sapienvulkan2 - Vulkan-based rendering engine";
    homepage = "https://example.com";
    license = licenses.bsd3;
    maintainers = with maintainers;
  };
}
