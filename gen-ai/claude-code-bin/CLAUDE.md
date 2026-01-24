# Claude Code Binary Package

This package distributes Claude Code as a precompiled binary from Anthropic's GCS bucket.

## Updating the Package

1. Get the latest version:
   ```bash
   curl -fsSL "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/latest"
   ```

2. Download the manifest for that version and replace `manifest.json`:
   ```bash
   curl -fsSL "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/<VERSION>/manifest.json" > manifest.json
   ```

3. Build and test:
   ```bash
   nix build .#claude-code-bin
   ./result/bin/claude --version
   ```

## Important: Do NOT Use autoPatchelfHook

The claude binary is a Bun single-file executable with embedded JavaScript bytecode. Using `autoPatchelfHook` corrupts this embedded bytecode, causing the binary to show Bun's default CLI instead of Claude's application.

Instead, we manually patch only the ELF interpreter using `patchelf --set-interpreter` to point to Nix's glibc. This minimal patching preserves the embedded bytecode.

## URL Structure

- Base: `https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases`
- Latest version (plain text): `<base>/latest`
- Manifest: `<base>/<version>/manifest.json`
- Binary: `<base>/<version>/<platform>/claude`

## Platform Keys

- `darwin-arm64` - macOS Apple Silicon
- `darwin-x64` - macOS Intel
- `linux-arm64` - Linux ARM64 (glibc)
- `linux-x64` - Linux x86_64 (glibc)
- `linux-arm64-musl` - Linux ARM64 (musl)
- `linux-x64-musl` - Linux x86_64 (musl)

The package uses `stdenv.hostPlatform.node.platform` and `stdenv.hostPlatform.node.arch` to construct the platform key, which maps to the glibc variants for standard NixOS/Nix builds.
