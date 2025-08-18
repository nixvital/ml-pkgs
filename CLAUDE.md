# Code Structures

The whole repo is managed by nix flakes and flake-parts. The entrypoint is @flake.nix, where the entrypoints to each of the categories are imported. For example,

- Generative AI related packages @gen-ai/part.nix
- Math related packages @math/part.nix
- Tools packages @tools/part.nix

# Packaging a Python Package

Many of the packages here are python projects packaged into Nix derivations. You can find a lot of examples under @gen-ai

## Convention

1. Use `buildPythonPackage` in a modern way.
   - Prefer `pyproject = True`
   - Prefer `fetchFromGitHub` for fetching the source code
   - Prefer using `build-system` and `dependencies`
   - Prefer `pythonImportsCheck` if needed
2. For dependencies that do not exist in `nixpkgs` yet or do not have the required versions in `nixpkgs` yet:
   - In a case-by-case fashion, determine whether those dependencies are necessary for the target package
   - For those that is absolutely needed, package the dependency as well.
   - Make decision on `pythonRelaxDeps` and `pythonRemoveDeps` for the others.
   - If you cannot decide, don't hesitate and ask for my help.
3. Inject the package into the overlay in the corresponding `part.nix`.
   - python packages in most cases will be injected using `pythonPackagesExtensions` in the overlay
   - In certain cases, the python package is actually an applicate, and we will use `toPythonApplication`
   - The packages added to the overlay will also be exposed to `packages` in `perSystem`, so that the user can use `nix build .#<package-name>` to test build it.
4. Preferences
   - Always build from source unless it is very hard to do so
   - Do not put hash in `fetchFromGitHub` (and similar constructs) in the first pass. Try build it and wait for it to fail. Harvest the actual hash from the error log.
