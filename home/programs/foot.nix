{ lib, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka Nerd Font Mono:size=14";
        selection-target = "clipboard";
      };

      colors = lib.mkForce {
        alpha = 0.9;
        background = "000000";
        foreground = "fce8c3";

        # scrcery
        regular0 = "1c1b19";
        regular1 = "ef2f27";
        regular2 = "519f50";
        regular3 = "fbb829";
        regular4 = "2c78bf";
        regular5 = "e02c6d";
        regular6 = "0aaeb3";
        regular7 = "baa67f";
        bright0 = "918175";
        bright1 = "f75341";
        bright2 = "98bc37";
        bright3 = "fed06e";
        bright4 = "68a8e4";
        bright5 = "ff5c8f";
        bright6 = "2be4d0";
        bright7 = "fce8c3";
      };
    };
  };
}
