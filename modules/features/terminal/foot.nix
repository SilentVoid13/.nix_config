{ ... }:
{
  flake.modules.homeManager.foot =
    { pkgs, ... }:
    {
      programs.foot = {
        enable = true;
        settings = {
          main = {
            font = "Iosevka Nerd Font Mono:size=14";
            selection-target = "clipboard";
          };
          colors = {
            alpha = pkgs.lib.mkForce 0.9;
            ## Scrcery
            foreground = "d9d2c2";
            background = "000000";
            regular0 = "1C1B19";
            regular1 = "EF2F27";
            regular2 = "519F50";
            regular3 = "FBB829";
            regular4 = "2C78BF";
            regular5 = "E02C6D";
            regular6 = "0AAEB3";
            regular7 = "BAA67F";
            bright0 = "918175";
            bright1 = "F75341";
            bright2 = "98BC37";
            bright3 = "FED06E";
            bright4 = "68A8E4";
            bright5 = "FF5C8F";
            bright6 = "53FDE9";
            bright7 = "FCE8C3";
          };
        };
      };
    };
}
