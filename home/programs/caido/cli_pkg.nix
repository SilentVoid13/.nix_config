{
  pkgs,
  version,
}:
with pkgs;
  stdenv.mkDerivation rec {
    pname = "caido-cli";
    inherit version;

    src = fetchurl {
      url = "https://storage.googleapis.com/caido-releases/v${version}/caido-cli-v${version}-linux-x86_64.tar.gz";
      hash = "sha256-I8UF2rzIKfpcrxyvDa4AReWDIHOKTCj3ERaWhG1xGG0=";
    };

    nativeBuildInputs = [
      autoPatchelfHook
    ];

    buildInputs = [
      libgcc
    ];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall
      install -m755 -D caido-cli $out/bin/caido-cli
      runHook postInstall
    '';

    meta = with lib; {
      homepage = "https://caido.io/";
      description = "A lightweight web security auditing toolkit";
      platforms = platforms.linux;
      license = licenses.unfree;
    };
  }
