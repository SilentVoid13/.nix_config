{
  pkgs,
  version,
}: let
  pname = "caido";
  src = pkgs.fetchurl {
    url = "https://storage.googleapis.com/caido-releases/v${version}/caido-desktop-v${version}-linux-x86_64.AppImage";
    hash = "sha256-DgXxOOWaLJG1h1nB+mkw77APh06WiJo9V9ZFCiWeha8=";
  };
  appimageContents = pkgs.appimageTools.extractType2 {inherit pname src version;};
in
  pkgs.appimageTools.wrapType2 {
    inherit pname src version;

    extraPkgs = pkgs: [pkgs.libthai];

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/caido.desktop -t $out/share/applications
      install -m 444 -D ${appimageContents}/caido.png \
        $out/share/icons/hicolor/512x512/apps/caido.png
      source "${pkgs.makeWrapper}/nix-support/setup-hook"
      wrapProgram $out/bin/${pname} \
        --set WEBKIT_DISABLE_COMPOSITING_MODE 1
    '';

    meta = with pkgs.lib; {
      homepage = "https://caido.io/";
      description = "A lightweight web security auditing toolkit";
      platforms = platforms.linux;
      license = licenses.unfree;
    };
  }
