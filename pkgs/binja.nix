{pkgs}: let
  python = pkgs.python3.withPackages (p: with p; [pip torch pyperclip]);
in
  pkgs.buildFHSEnv {
    name = "binaryninja";
    targetPkgs = pkgs:
      with pkgs; [
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
        qt6.full
        qt6.qtbase
        glib

        ## plugins stuff
        python
        astyle

        ## useful headers
        openssl.dev
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
      export PYTHONPATH="${python}/lib/python3.12/site-packages:$PYTHONPATH"
      "$HOME/binaryninja/binaryninja" "$@"
    '';
    meta = {
      description = "BinaryNinja";
      platforms = ["x86_64-linux"];
    };
    multiArch = true;
  }
