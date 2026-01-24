{
  lib,
  stdenvNoCC,
  fetchurl,
  installShellFiles,
  makeWrapper,
  patchelf,
  glibc,
  darwin,
  bubblewrap,
  procps,
  socat,
  versionCheckHook,
  writableTmpDirAsHomeHook,
}:
let
  stdenv = stdenvNoCC;
  baseUrl = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases";
  manifest = lib.importJSON ./manifest.json;
  platformKey = "${stdenv.hostPlatform.node.platform}-${stdenv.hostPlatform.node.arch}";
  platformManifestEntry = manifest.platforms.${platformKey};
in
stdenv.mkDerivation (finalAttrs: {
  pname = "claude-code-bin";
  version = manifest.version;

  src = fetchurl {
    url = "${baseUrl}/${finalAttrs.version}/${platformKey}/claude";
    sha256 = platformManifestEntry.checksum;
  };

  dontUnpack = true;  # The downloaded $src is already the self-contained binary itself.

  nativeBuildInputs = [
    installShellFiles
    makeWrapper
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ patchelf ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [ darwin.autoSignDarwinBinariesHook ];

  strictDeps = true;

  installPhase = ''
    runHook preInstall

    installBin $src

    ${lib.optionalString stdenv.hostPlatform.isLinux ''
      # Patch the ELF interpreter to use Nix's glibc.
      # Only patch interpreter (not RPATH) to avoid corrupting Bun's embedded bytecode.
      patchelf --set-interpreter ${glibc}/lib/ld-linux-${
        if stdenv.hostPlatform.isx86_64 then "x86-64.so.2" else "aarch64.so.1"
      } $out/bin/claude
    ''}

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/claude \
      --set DISABLE_AUTOUPDATER 1 \
      --unset DEV \
      --prefix PATH : ${
        lib.makeBinPath (
          [
            # claude-code uses [node-tree-kill](https://github.com/pkrumins/node-tree-kill) which requires procps's pgrep(darwin) or ps(linux)
            procps
          ]
          # the following packages are required for the sandbox to work (Linux only)
          ++ lib.optionals stdenv.hostPlatform.isLinux [
            bubblewrap
            socat
          ]
        )
      }
  '';

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    writableTmpDirAsHomeHook
    versionCheckHook
  ];
  versionCheckKeepEnvironment = [ "HOME" ];
  versionCheckProgramArg = "--version";

  meta = {
    description = "Agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster";
    homepage = "https://github.com/anthropics/claude-code";
    downloadPage = "https://claude.com/product/claude-code";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [
      "aarch64-darwin"
      "x86_64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
    maintainers = with lib.maintainers; [
      xiaoxiangmoe
    ];
    mainProgram = "claude";
  };
})
