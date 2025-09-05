{
  pkgs,
  config,
  ...
}:
let
  deps = with pkgs; [
    wayland
    libxkbcommon
    fontconfig
    libGL
    stdenv.cc.cc
    zlib
    glib
    gtk4
    gtk3
  ];
  ld_libs = pkgs.lib.makeLibraryPath deps;
  jfolder = "${config.home.homeDirectory}/jeb";
  wrap_bin =
    name:
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = with pkgs; [ jdk17 ];
      text = ''
        export 

        if ! command -v firejail &>/dev/null
        then
            echo -e "firejail not found."
            exit 1
        fi
        firejail \
            --net=none \
            --env=LD_LIBRARY_PATH="${ld_libs}" \
            --env=XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS" \
            -- "${jfolder}/jeb_linux.sh"
      '';
    };
in
{
  home.packages = [
    (wrap_bin "jeb")
  ];

  xdg.desktopEntries = {
    "jeb" = {
      name = "jeb";
      exec = "jeb %u";
      # icon = "";
      mimeType = [ ];
      categories = [ "Utility" ];
      type = "Application";
      terminal = false;
    };
  };
}
