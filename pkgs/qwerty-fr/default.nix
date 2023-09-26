# TODO: fix this pkg, it doesn't work atm because /usr/share/X11/xkb is
# ignored for some reason
# We also need to force the path link with environment.pathsToLink
{pkgs}:
pkgs.stdenv.mkDerivation rec {
  pname = "qwerty-fr";
  version = "0.7.2";

  src = pkgs.fetchzip {
    url = "https://github.com/qwerty-fr/qwerty-fr/releases/download/v${version}/qwerty-fr_${version}_linux.zip";
    hash = "sha256-ARTNVMyKa3C1a1XSxn+N63q4/6rfETkzRwF5Qv+Qhp0=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -D -m 644 ./usr/share/X11/xkb/symbols/us_qwerty-fr $out/share/X11/xkb/symbols/us_qwerty-fr

    install -D -m 644 ./usr/share/doc/xkb-qwerty-fr/changelog.gz $out/share/doc/xkb-qwerty-fr/changelog.gz
    install -D -m 644 ./usr/share/doc/xkb-qwerty-fr/copyright $out/share/doc/xkb-qwerty-fr/copyright
    install -D -m 644 ./usr/share/doc/xkb-qwerty-fr/keymap.txt $out/share/doc/xkb-qwerty-fr/keymap.txt

    install -D -m 644 ./usr/share/man/man7/qwerty-fr.7.gz $out/share/man/man7/qwerty-fr.7.gz
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Qwerty keyboard layout with French accents";
    homepage = "https://github.com/qwerty-fr/qwerty-fr";
    license = licenses.mit;
    maintainers = with lib.maintainers; [silentvoid];
    platforms = ["x86_64-linux"];
  };
}
