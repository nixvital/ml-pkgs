{
  lib,
  stdenv,
  fetchurl,
}:
{
  fetchLibrustyV8 =
    { version, hashes }:
    let
      rustcTarget = stdenv.hostPlatform.rust.rustcTarget;
      url = "https://github.com/denoland/rusty_v8/releases/download/v${version}/librusty_v8_release_${rustcTarget}.a.gz";
    in
    fetchurl {
      inherit url;
      hash = hashes.${stdenv.hostPlatform.system} or (throw "unsupported platform: ${stdenv.hostPlatform.system}");
    };
}
