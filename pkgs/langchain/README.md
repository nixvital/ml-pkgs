# Semi-automated Update of the LangChain Package

This package `langchain` has a huge amount of optional packages and
therefore would like to manage it with ease.

To semi-automatically update it, you will need to clone the langchain
git repo, checkout the version you want to package, and run

```bash
$ nix run .\#extract-langchain-deps ~/path/to/langchain/pyproject.toml
```

It will generate the desired `default.nix`. Please check whether there
are warnings about newly added packages. If so, update
`extract-langchain-deps.nix` to reflect that.

When all warnings are gone, you can then do

```bash
nix run .\#extract-langchain-deps ~/projects/other/langchain/pyproject.toml > pkgs/langchain/default.nix
```

to update `default.nix`. Please note that at this moment `src.hash` is
not filled and you can run `nix build .#langchain` once to get the
hash and fill it in.
