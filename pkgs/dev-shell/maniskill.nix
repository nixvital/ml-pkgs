{ mkShell
, python3
, linuxPackages
, vulkan-loader
}:

mkShell rec {
  name = "maniskill";

  # TODO: fix these hacks
  VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
  __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
  LD_LIBRARY_PATH = "/run/opengl-driver/lib:${vulkan-loader}/lib/libvulkan.so.1";

  packages = [
    (python3.withPackages (p: with p; [
      maniskill
    ]))
  ];
}
