{pkgs}:
pkgs.buildFHSEnv {
  name = "binaryninja";
  targetPkgs = pkgs:
    with pkgs; [
      dbus
      fontconfig
      freetype
      libGL
      libxkbcommon
      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pip
        python-pkgs.lz4
      ]))
      xorg.libX11
      xorg.libxcb
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      wayland
      zlib
      libxml2

      # useful headers
      openssl.dev
      linuxHeaders
      stdenv
      glibc.dev
    ];
  runScript = pkgs.writeScript "binaryninja.sh" ''
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
