{ pkgs, }:
pkgs.buildFHSEnv {
  name = "binaryninja";
  targetPkgs = pkgs:
    with pkgs; [
      dbus
      fontconfig
      freetype
      libGL
      libxkbcommon
      python3
      xorg.libX11
      xorg.libxcb
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      wayland
      zlib
    ];
  runScript = pkgs.writeScript "binaryninja.sh" ''
    set -e
    exec "$HOME/binaryninja/binaryninja" -platform wayland
  '';
  meta = {
    description = "BinaryNinja";
    platforms = ["x86_64-linux"];
  };
  multiArch = true;
}
