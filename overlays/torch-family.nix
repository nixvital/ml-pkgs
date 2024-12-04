final: prev:

{
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {

      # The newer version of torch decides to lazily load `nvrtc` but apparently
      # it did not explicitly list it as a dependency:
      # https://github.com/NixOS/nixpkgs/issues/296179
      #
      # This is @SomeoneSerge's temporary fix:
      # https://github.com/SomeoneSerge/dust3r.nix/commit/8715f78a6f875fa5a1795da8f56e05fe2b2811d6
      #
      # The proper fix is still a pending PR: https://github.com/NixOS/nixpkgs/pull/297590
      torchWithCuda = python-prev.torchWithCuda.overridePythonAttrs (oldAttrs: {
        extraRunpaths = [ "${prev.lib.getLib final.cudaPackages.cuda_nvrtc}/lib" ];
        postPhases = prev.lib.optionals final.stdenv.hostPlatform.isUnix ["postPatchelfPhase" ];
        postPatchelfPhase = ''
          while IFS= read -r -d $'\0' elf ; do
            for extra in $extraRunpaths ; do
              echo patchelf "$elf" --add-rpath "$extra" >&2
              patchelf "$elf" --add-rpath "$extra"
            done
          done < <(
            find "''${!outputLib}" "$out" -type f -iname '*.so' -print0
          )
        '';
      });

      torchmetrics = python-prev.torchmetrics.override {
        torch = python-final.torchWithCuda;
      };

      tensorboardx = python-prev.tensorboardx.override {
        torch = python-final.torchWithCuda;
      };

      pytorch-lightning = python-prev.pytorch-lightning.override {
        torch = python-final.torchWithCuda;
      };

      torchvision = python-prev.torchvision.override {
        torch = python-final.torchWithCuda;
      };

      pytorchviz = python-final.callPackage ../pkgs/pytorchviz {
        pytorch = python-final.torchWithCuda;
      };

      # Override to use a customized version of pytorch, built against
      # newer version of CUDA.

      wandb = python-prev.wandb.override {
        torch = python-final.torchWithCuda;
      };

      transformers = python-prev.transformers.override {
        torch = python-final.torchWithCuda;
      };

      accelerate = python-prev.accelerate.override {
        torch = python-final.torchWithCuda;
      };

      manifest-ml = python-prev.manifest-ml.override {
        torch = python-final.torchWithCuda;
      };

      peft = python-prev.peft.override {
        torch = python-final.torchWithCuda;
      };

      lion-pytorch = python-prev.lion-pytorch.override {
        torch = python-final.torchWithCuda;
      };

      bitsandbytes = python-prev.bitsandbytes.override {
        torch = python-final.torchWithCuda;
      };

      sentence-transformers = python-prev.sentence-transformers.override {
        torch = python-final.torchWithCuda;
      };

      clip = python-prev.clip.override {
        torch = python-final.torchWithCuda;
      };

      rerun-sdk = python-prev.rerun-sdk.override {
        torch = python-final.torchWithCuda;        
      };

      safetensors = python-prev.safetensors.override {
        torch = python-final.torchWithCuda;
      };
    })
  ];
}
