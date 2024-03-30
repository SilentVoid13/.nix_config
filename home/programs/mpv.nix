{
  pkgs,
  nixGLWrap,
  ...
}: {
  programs.mpv = {
    enable = true;
    package = nixGLWrap pkgs.mpv;
  };
}
