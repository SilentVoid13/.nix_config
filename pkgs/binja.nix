{pkgs}:
pkgs.buildFHSEnv {
  name = "binaryninja";
  targetPkgs = pkgs:
    with pkgs; [
      autoPatchelfHook
      makeWrapper

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

      python3.pkgs.wrapPython

      # useful headers
      openssl.dev
      linuxHeaders
      #linux_5_15.dev
      stdenv
      glibc.dev
    ];
  runScript = pkgs.writeShellScript "binaryninja.sh" ''
    #virtualenv ~/binja_venv
    #source ~/binja_venv/bin/activate
    set -e
    exec "$HOME/binaryninja/binaryninja"
  '';
  meta = {
    description = "BinaryNinja";
    platforms = ["x86_64-linux"];
  };
  multiArch = true;
}
