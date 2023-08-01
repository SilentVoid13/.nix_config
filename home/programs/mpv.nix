{
  config,
  pkgs,
  specialArgs,
  ...
}: let
    nixGLWrap = specialArgs.nixGLWrap;
in {
  programs.mpv = {
    enable = true;
    package = nixGLWrap pkgs.mpv;
  };
}
