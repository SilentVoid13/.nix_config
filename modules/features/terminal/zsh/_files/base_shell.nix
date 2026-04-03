{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  name = "shell_env";
  packages = with pkgs; [
    # wayland
    # libxkbcommon
    # fontconfig
    # libGL
    # stdenv.cc.cc
    # zlib
    # glib
  ];
  #LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath packages}";
}
