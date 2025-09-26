{
  pkgs,
  ...
}:
let
  jadx_pkg = pkgs.stdenv.mkDerivation rec {
    pname = "jadx";
    version = "r2508.f01e6aa";
    # version = "1.5.3";

    src = pkgs.fetchzip {
      # url = "https://github.com/skylot/jadx/releases/download/v${version}/jadx-${version}.zip";
      url = "https://nightly.link/skylot/jadx/workflows/build-artifacts/master/jadx-${version}.zip";
      sha256 = "sha256-MoPl/3zFNP+DP9jb666KGJpQJ1C5sV+UehweZzDQZcM=";
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
in
{
  home.packages = [ jadx_pkg ];
}
