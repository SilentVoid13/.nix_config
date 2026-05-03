{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.custom_jadx = pkgs.stdenv.mkDerivation rec {
        pname = "jadx";
        version = "r2655.bce6611";

        src = pkgs.fetchzip {
          url = "https://nightly.link/skylot/jadx/workflows/build-artifacts/master/jadx-${version}.zip";
          sha256 = "sha256-E8E2UsB2DkBBWiHcDuEXpQFJ1CM9gFYwwvPdTPWzrwU=";
          stripRoot = false;
        };

        nativeBuildInputs = [ pkgs.makeWrapper ];
        buildInputs = [ pkgs.jdk ];

        installPhase = with pkgs; ''
          mkdir -p $out
          cp -r bin lib $out/

          # patch launchers to use nixpkgs' java
          for f in $out/bin/jadx $out/bin/jadx-gui; do
            substituteInPlace $f \
              --replace 'exec java' "exec ${jdk}/bin/java"
          done

          wrapProgram $out/bin/jadx \
            --set-default JAVA_HOME ${jdk}

          wrapProgram $out/bin/jadx-gui \
            --set-default JAVA_HOME ${jdk}
        '';

        meta = with pkgs.lib; {
          description = "Dex to Java decompiler";
          homepage = "https://github.com/skylot/jadx";
          platforms = platforms.all;
        };
      };
    };

  flake.modules.homeManager.jadx =
    { pkgs, ... }:
    {
      home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.custom_jadx ];

      xdg.desktopEntries = {
        "jadx" = {
          name = "JADX";
          exec = "jadx-gui";
          categories = [ "Utility" ];
          type = "Application";
          terminal = false;
        };
      };
    };
}
