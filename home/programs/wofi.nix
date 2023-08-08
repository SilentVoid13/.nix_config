{
  config,
  pkgs,
  ...
}: let
in {
    programs.wofi = {
        enable = false;
        settings = {
            gtk_dark = true;
            insensitive = true;
        };
    };
}
