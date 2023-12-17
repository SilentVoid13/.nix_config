{
  config,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
  gitignore_global = "git/gitignore_global";
in {
  #imports = [
  #  ( import ./mypkg.nix { inherit pkgs; } )
  #];
  home.packages = [
    ( import ./mypkg.nix { inherit pkgs; } )
  ];

  home.file.".binaryninja/keybindings.json" = {
    source = ./keybindings.json;
  };

  home.file.".binaryninja/settings.json" = {
    source = ./settings.json;
  };
}
