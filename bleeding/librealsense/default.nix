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
, enablePython ? false, pythonPackages ? null
, enableGUI ? false,
}:

assert enablePython -> pythonPackages != null;

stdenv.mkDerivation rec {
  pname = "librealsense";
  version = "2.54.2";

  outputs = [ "out" "dev" ];

  src = fetchFromGitHub {
    owner = "IntelRealSense";
    repo = pname;
    rev = "4673a37d981164af8eeb8e296e430fc1427e008d";
    hash = "sha256-tdXd2+II43inpG57JDDMqqXJJPHUaBo4ayjy5Xp8zQA=";
  };

  buildInputs = [
    libjpeg
    libusb1
    gcc.cc.lib
  ] ++ lib.optionals enablePython (with pythonPackages; [ python pybind11 ])
    ++ lib.optionals enableGUI [ mesa gtk3 glfw libGLU curl ];

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
  ] ++ lib.optionals enablePython [
    "-DBUILD_PYTHON_BINDINGS:bool=true"
    "-DXXNIX_PYTHON_SITEPACKAGES=${placeholder "out"}/${pythonPackages.python.sitePackages}"
  ];

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
