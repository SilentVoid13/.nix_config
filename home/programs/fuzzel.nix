{
  config,
  pkgs,
  ...
}: let
in {
    programs.fuzzel = {
        enable = true;
        settings = {
            main = {
                icon-theme = "Papirus-Dark";
            }
            colors = {
                background="282a36dd";
                text="f8f8f2ff";
                match="8be9fdff";
                selection-match="8be9fdff";
                selection="44475add";
                selection-text="f8f8f2ff";
                border="bd93f9ff";
            };
        };
    };
}
