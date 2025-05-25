{ fetchFromGitHub }:

(rec {
  version = "0.4.6";

  sglang = fetchFromGitHub {
    owner = "sgl-project";
    repo = "sglang";
    tag = "v${version}";
    hash = "sha256-sL12YSvNT9G/K0ubxfZK/i/j7+zsQD8MngMRyc4qUnU=";
  };

  cutlass = fetchFromGitHub {
    owner = "NVIDIA";
    repo = "cutlass";
    # Using the revision obtained in submodule inside flashinfer's `3rdparty`.
    rev = "df8a550d3917b0e97f416b2ed8c2d786f7f686a3";
    hash = "sha256-d4czDoEv0Focf1bJHOVGX4BDS/h5O7RPoM/RrujhgFQ=";
  };
})
