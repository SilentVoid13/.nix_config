{
  pkgs,
  pkgs-stable,
  config,
  ...
}:
let
  python = pkgs-stable.python312.withPackages (
    ps: with ps; [
      toml
      pip
      pyelftools
    ]
  );

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
    xorg.libX11
    xorg.xcbutilwm
    xorg.xcbutilimage
    xorg.libxcb
    xorg.xcbutilrenderutil
    xorg.xcbutilkeysyms
    xorg.xcbutilerrors
    xorg.xcbutil
    xorg.xcbproto
    xorg.libSM
    xorg.libICE
    wayland
    libxkbcommon
    dbus.lib

    python
  ];
  ld_libs = pkgs.lib.makeLibraryPath deps;
  ifolder = "${config.home.homeDirectory}/ida-pro";
  wrap_bin =
    name:
    pkgs.writeShellScriptBin name ''
      export NIX_LD="${pkgs.stdenv.cc.bintools.dynamicLinker}"
      export NIX_LD_LIBRARY_PATH="${ld_libs}"
      export QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt5.qtbase}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms";

      # for plugins
      export PATH="${python}/bin:$PATH"
      export PYTHONPATH="${python}/lib/python3.12/site-packages:$PYTHONPATH"

      which python

      if ! command -v firejail &>/dev/null
      then
          echo -e "firejail not found."
          exit 1
      fi
      firejail --net=none -- "${ifolder}/ida"
    '';
in
{
  home.packages = [
    (wrap_bin "ida")
    (wrap_bin "idat")
  ];

  xdg.desktopEntries = {
    "ida" = {
      name = "IDA";
      exec = "ida %u";
      icon = "${ifolder}/appico.png";
      mimeType = [ ];
      categories = [ "Utility" ];
      type = "Application";
      terminal = false;
    };
  };
}
