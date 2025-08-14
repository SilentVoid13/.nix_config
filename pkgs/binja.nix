{
  pkgs,
  ...
}:
let
  python = pkgs.python3.withPackages (
    p: with p; [
      pip
      torch
      pyperclip
      flatbuffers
    ]
  );
  libxml2_13 = pkgs.libxml2.overrideAttrs rec {
    version = "2.13.8";
    src = pkgs.fetchurl {
      url = "mirror://gnome/sources/libxml2/${pkgs.lib.versions.majorMinor version}/libxml2-${version}.tar.xz";
      hash = "sha256-J3KUyzMRmrcbK8gfL0Rem8lDW4k60VuyzSsOhZoO6Eo=";
    };
  };
in
pkgs.buildFHSEnv {
  name = "binaryninja";
  targetPkgs =
    pkgs: with pkgs; [
      dbus
      fontconfig
      freetype
      libGL
      libxkbcommon
      xorg.libX11
      xorg.libxcb
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      wayland
      zlib
      libxml2
      libxml2_13
      qt6.full
      qt6.qtbase
      glib

      ## plugins stuff
      python
      astyle

      ## useful headers
      openssl.dev
      openssl_3
      linuxHeaders
      #linux_5_15.dev
      stdenv
      glibc.dev
    ];

  # NOTE: we enter a dedicated venv to pip install for plugins
  runScript = pkgs.writeShellScript "binaryninja.sh" ''
    set -e
    # allows pip install for plugins
    export PATH="${python}/bin:$PATH"
    export PYTHONPATH="${python}/lib/python3.13/site-packages:$PYTHONPATH"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
      pkgs.lib.makeLibraryPath [
        pkgs.openssl
        pkgs.openssl_3
      ]
    }"
    "$HOME/binaryninja/binaryninja" "$@"
  '';
  meta = {
    description = "BinaryNinja";
    platforms = [ "x86_64-linux" ];
  };
  multiArch = true;
}
