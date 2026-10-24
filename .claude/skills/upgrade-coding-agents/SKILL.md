---
name: upgrade-coding-agents
description: Upgrade claude-code-bin and codex (gen-ai/) to their latest releases, verify the builds, and commit. Use when asked to upgrade or update claude, claude-code-bin, or codex.
---

# Upgrade claude-code-bin and codex

Run from the repo root. Use `set -o pipefail` whenever you pipe a build into `tail` or `grep`. Without it, a failed build looks like a success.

## 1. Check versions

```bash
B=https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases
curl -fsSL $B/latest; jq -r .version gen-ai/claude-code-bin/manifest.json
git ls-remote --tags https://github.com/openai/codex 'rust-v*' \
  | grep -v -- '-alpha\|-beta\|\^{}' | sed 's|.*rust-v||' | sort -V | tail -1
grep 'version =' gen-ai/codex/package.nix
```

Skip any package that is already current.

## 2. claude-code-bin

The manifest supplies both the version and the checksums. See `gen-ai/claude-code-bin/CLAUDE.md`.

```bash
curl -fsSL $B/<ver>/manifest.json > gen-ai/claude-code-bin/manifest.json
nix build .#claude-code-bin -o result-claude
./result-claude/bin/claude --version && rm result-claude
```

## 3. codex

Shallow-clone the tag into the scratchpad and check it before editing the package:

```bash
git clone -q --depth 1 --branch rust-v<ver> https://github.com/openai/codex <scratch>/codex-src
cd <scratch>/codex-src/codex-rs
grep -A1 '^name = "v8"' Cargo.lock                  # must match librusty_v8.nix
grep -n 'lto = "thin"\|codegen-units = 4' Cargo.toml  # postPatch removes both
for p in continue-after-trust-write-failure no-daemon_auto_start; do
  patch -p1 --dry-run < <repo>/gen-ai/codex/$p.patch
done
```

Use `patch --dry-run`, not `git apply`. Inside a subdirectory, `git apply` silently skips files.

**v8 changed:** update `version` and all four `shas` in both `librusty_v8.nix` and `librusty_v8_src_binding.nix`:

```bash
U=https://github.com/denoland/rusty_v8/releases/download/v<v8ver>
for t in x86_64-unknown-linux-gnu aarch64-unknown-linux-gnu x86_64-apple-darwin aarch64-apple-darwin; do
  for f in librusty_v8_release_$t.a.gz src_binding_release_$t.rs; do
    echo "$f $(nix store prefetch-file --json $U/$f | jq -r .hash)"
  done
done
```

**A patch fails:** apply the hunks that still work, fix the rest by hand in `codex-src/codex-rs`, then regenerate the patch with `git diff --relative > <repo>/gen-ai/codex/<name>.patch`. `no-daemon_auto_start.patch` turns off the daemon that breaks the Nix-packaged CLI (openai/codex#48195). Never drop it.

**Profile lines gone:** the `--replace-fail` calls in `postPatch` will fail. Update or remove them.

Bump the version and harvest the two hashes. The source hash comes first:

```bash
sed -i 's/version = "<old>"/version = "<ver>"/; 0,/hash = "sha256-[^"]*"/s//hash = lib.fakeHash/; s/cargoHash = "sha256-[^"]*"/cargoHash = lib.fakeHash/' gen-ai/codex/package.nix
H=$(nix build .#codex 2>&1 | grep -oP 'got:\s+\K\S+')
sed -i "0,/hash = lib.fakeHash/s||hash = \"$H\"|" gen-ai/codex/package.nix
H=$(nix build .#codex 2>&1 | grep -oP 'got:\s+\K\S+')
sed -i "s|cargoHash = lib.fakeHash|cargoHash = \"$H\"|" gen-ai/codex/package.nix
```

The full build takes a long time, so run it in the background:

```bash
set -o pipefail && nix build .#codex -L 2>&1 | tail -15 \
  && ./result/bin/codex --version \
  && CODEX_HOME=$(mktemp -d) ./result/bin/codex features list | grep daemon
```

The `daemon_auto_start` line must show `false`.

## 4. Commit

Make one commit per package, titled `Upgrade <pkg> to <ver>`. Add a short body only for extra work, such as a v8 bump or a refreshed patch. `git push` prints "Changes must be made through a pull request", but the push still succeeds. Check the `old..new main -> main` line.
