{ lib
, stdenv
, gcc12Stdenv
, buildPythonPackage
, fetchFromGitHub
, cmake
, pkg-config
, python3Packages
, eigen
, boost
, urdfdom
, numpy
, torch
, console-bridge
, tinyxml-2
, cudatoolkit
}:

buildPythonPackage rec {
  pname = "fast_kinematics";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "Lexseal";
    repo = pname;
    rev = "2a174121369bc9c570b05d0ccb0e926cbecdc1ce";
    sha256 = "sha256-WA97O2C8PHGghLJe03AQ4PtS2+WFKj5WPA6oaIWv4RU=";
  };

  stdenv = gcc12Stdenv;

  build-system = with python3Packages; [
    setuptools
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  propagatedBuildInputs = [
    eigen
    boost
    urdfdom
    numpy
    torch.lib # figure out what each one of these are for
    torch.dev
    console-bridge
    tinyxml-2
    cudatoolkit
  ];

  meta = with lib; {
    homepage = "https://github.com/Lexseal/fast_kinematics";
    description = "Cuda enabled library for calculating forward kinematics and Jacobian of a kinematics chain.";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
