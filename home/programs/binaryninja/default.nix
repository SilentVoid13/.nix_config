{
  config,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
  gitignore_global = "git/gitignore_global";
in {
    home.file.".binaryninja/keybindings.json" = {
        source = ./keybindings.json;
    };

    home.file.".binaryninja/settings.json" = {
        source = ./settings.json;
    };
}
