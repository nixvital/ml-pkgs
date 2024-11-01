{ mkShell
, python3
}:

mkShell rec {
  name = "maniskill";

  packages = [
    (python3.withPackages (p: with p; [
      torchWithCuda
      # pytorchviz
      # LIV-robotics
      sapien
      # maniskill
    ]))
  ];
}
    