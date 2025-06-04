{ fetchFromGitHub }:

(rec {
  version = "0.4.6.post4";

  sglang = fetchFromGitHub {
    owner = "sgl-project";
    repo = "sglang";
    tag = "v${version}";
    hash = "sha256-Nuvz+j/LJ2AXb8UBYqk/Jny4HTwaeW37EORFIp8SjQ4=";
  };

  cutlass = fetchFromGitHub {
    owner = "NVIDIA";
    repo = "cutlass";
    # Using the revision obtained in submodule inside flashinfer's `3rdparty`.
    rev = "df8a550d3917b0e97f416b2ed8c2d786f7f686a3";
    hash = "sha256-d4czDoEv0Focf1bJHOVGX4BDS/h5O7RPoM/RrujhgFQ=";
  };

  deepgemm = fetchFromGitHub {
    owner = "deepseek-ai";
    repo = "DeepGEMM";
    rev = "d75b218b7b8f4a5dd5406ac87905039ead3ae42f";
    hash = "sha256-K9+OPOpvG0mHMWKlN3W/gUZtFsMpK1oHt3YSaBRmje4=";
  };

  flashinfer = fetchFromGitHub {
    owner = "flashinfer-ai";
    repo = "flashinfer";
    rev = "9220fb3443b5a5d274f00ca5552f798e225239b7";
    hash = "sha256-JwyaHAd/YUvlHcAX8Y9AXRHeXd1CT3PGwwQYdaG4BC4=";
  };

  flash-attention = fetchFromGitHub {
    owner = "sgl-project";
    repo = "sgl-attn";
    rev = "464f7acf1171f17c716091efcafeda22a2b3b936";
    hash = "sha256-fpesPZMOouA0KAV0xMUMD4YuGO6GOPR4OywMaHuL730=";
  };
})
