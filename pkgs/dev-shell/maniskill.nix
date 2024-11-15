{ lib
, mkShell
, linuxPackages
, vulkan-loader
, python3Packages
, wayland
}:

mkShell rec {
  name = "maniskill";

  # TODO: fix these hacks
  VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
  __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
  LD_LIBRARY_PATH = lib.makeLibraryPath [
    "/run/opengl-driver"
    vulkan-loader
    wayland
  ];

  venvDir = "./env";
  packages = with python3Packages; [
    venvShellHook
    python
    maniskill
    mujoco
    pybullet
    debugpy
  ];
}
