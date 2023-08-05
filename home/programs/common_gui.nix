{
  config,
  pkgs,
  specialArgs,
  ...
}: let 
    nixGLWrap = specialArgs.nixGLWrap;
in {
  home.packages = with pkgs; [
    webcord
    qalculate-gtk
    (nixGLWrap okular)
    (nixGLWrap obsidian)
    onlyoffice-bin
    _1password-gui
  ];
}
