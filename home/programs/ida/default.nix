{
  pkgs,
  config,
  ...
}: let
  deps = with pkgs; [
    stdenv.cc.cc
    libglvnd
    zlib
    glib
    ncurses
    libsecret
    fontconfig
    freetype
    openssl
    xorg.libX11.out
    xorg.xcbutilwm.out
    xorg.xcbutilimage.out
    xorg.libxcb.out
    xorg.xcbutilrenderutil.out
    xorg.xcbutilkeysyms.out
    xorg.xcbutilerrors
    xorg.xcbutil.out
    xorg.xcbproto.out
    xorg.libSM.out
    xorg.libICE.out
    wayland
    libxkbcommon.out
    dbus.lib

    python311.out
    python311Packages.qtconsole.out
  ];
  ld_libs = pkgs.lib.makeLibraryPath deps;
  ifolder = "${config.home.homeDirectory}/ida-pro";
  wrap_bin = name:
    pkgs.writeShellScriptBin name ''
      export NIX_LD="${pkgs.stdenv.cc.bintools.dynamicLinker}"
      export NIX_LD_LIBRARY_PATH="${ld_libs}"
      #export QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms";
      export QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt5.full}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms";

      if ! command -v firejail &>/dev/null
      then
          echo -e "firejail not found."
          exit 1
      fi
      firejail --net=none -- "${ifolder}/${name}"
    '';
in {
  home.packages = [
    (wrap_bin "ida")
    (wrap_bin "idat")
  ];

  xdg.desktopEntries = {
    "ida" = {
      name = "IDA";
      exec = "ida %u";
      icon = "${config.home.homeDirectory}/${ifolder}/appico.png";
      mimeType = [];
      categories = ["Utility"];
      type = "Application";
      terminal = false;
    };
  };
}
