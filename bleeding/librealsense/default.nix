{ stdenv
, config
, lib
, fetchFromGitHub
, fetchpatch
, cmake
, libusb1
, libjpeg
, ninja
, nasm
, pkg-config
, gcc
, mesa
, gtk3
, glfw
, libGLU
, curl
, cudaSupport ? config.cudaSupport or false, cudaPackages ? {}
, enablePython ? false, pythonPackages ? null
, enableGUI ? false,
}:

assert cudaSupport -> (cudaPackages?cudatoolkit && cudaPackages.cudatoolkit != null);
assert enablePython -> pythonPackages != null;

stdenv.mkDerivation rec {
  pname = "librealsense";
  version = "2023.03.20";

  outputs = [ "out" "dev" ];

  src = ../../../.;

  buildInputs = [
    libjpeg
    libusb1
    gcc.cc.lib
  ] ++ lib.optional cudaSupport cudaPackages.cudatoolkit
    ++ lib.optionals enablePython (with pythonPackages; [ python pybind11 ])
    ++ lib.optionals enableGUI [ mesa gtk3 glfw libGLU curl ];

  patches = [
    ./0001-Patch-to-use-libjpeg-turbo-in-a-more-proper-approach.patch
  ];

  postPatch = ''
    # https://github.com/IntelRealSense/librealsense/issues/11092
    # insert a "#include <iostream" at beginning of file
    sed '1i\#include <iostream>' -i wrappers/python/pyrs_device.cpp
  '';

  nativeBuildInputs = [
    cmake
    ninja
    nasm
    pkg-config
  ];

  cmakeFlags = [
    "-DBUILD_EXAMPLES=ON"
    "-DBUILD_GRAPHICAL_EXAMPLES=${lib.boolToString enableGUI}"
    "-DBUILD_GLSL_EXTENSIONS=${lib.boolToString enableGUI}"
    "-DCHECK_FOR_UPDATES=OFF" # activated by BUILD_GRAPHICAL_EXAMPLES, will make it download and compile libcurl
    # Extra flags for Hobot deployment
    "-DBUILD_NETWORK_DEVICE=ON"
    "-DFORCE_RSUSB_BACKEND=ON"
  ] ++ lib.optionals enablePython [
    "-DBUILD_PYTHON_BINDINGS:bool=true"
    "-DXXNIX_PYTHON_SITEPACKAGES=${placeholder "out"}/${pythonPackages.python.sitePackages}"
  ] ++ lib.optional cudaSupport "-DBUILD_WITH_CUDA:bool=true";

  # ensure python package contains its __init__.py. for some reason the install
  # script does not do this, and it's questionable if intel knows it should be
  # done
  # ( https://github.com/IntelRealSense/meta-intel-realsense/issues/20 )
  postInstall = lib.optionalString enablePython  ''
    cp ../wrappers/python/pyrealsense2/__init__.py $out/${pythonPackages.python.sitePackages}/pyrealsense2
  '';

  meta = with lib; {
    description = "A cross-platform library for Intel® RealSense™ depth cameras (D400 series and the SR300)";
    homepage = "https://github.com/IntelRealSense/librealsense";
    license = licenses.asl20;
    maintainers = with maintainers; [ brian-dawn pbsds breakds ];
    platforms = platforms.unix;
  };
}
