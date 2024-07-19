{lib, ...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        # handled by stylix
        #font = "terminus:size=12";
        #font = "Iosevka Nerd Font Mono:size=12";
        #font = "Iosevka:size=12";

        selection-target = "clipboard";
      };


      colors = lib.mkForce {
        alpha = 0.9;
        background = "000000";
        foreground = "fce8c3";
      };
      # handled by stylix
      /*
      colors = {
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

        # gruvbox-dark
        #regular0 = "282828";
        #regular1 = "cc241d";
        #regular2 = "98971a";
        #regular3 = "d79921";
        #regular4 = "458588";
        #regular5 = "b16286";
        #regular6 = "689d6a";
        #regular7 = "a89984";
        #bright0 = "928374";
        #bright1 = "fb4934";
        #bright2 = "b8bb26";
        #bright3 = "fabd2f";
        #bright4 = "83a598";
        #bright5 = "d3869b";
        #bright6 = "8ec07c";
        #bright7 = "ebdbb2";

        # tokyonight-night
        #regular0 = "15161E";
        #regular1 = "f7768e";
        #regular2 = "9ece6a";
        #regular3 = "e0af68";
        #regular4 = "7aa2f7";
        #regular5 = "bb9af7";
        #regular6 = "7dcfff";
        #regular7 = "a9b1d6";
        #bright0 = "414868";
        #bright1 = "f7768e";
        #bright2 = "9ece6a";
        #bright3 = "e0af68";
        #bright4 = "7aa2f7";
        #bright5 = "bb9af7";
        #bright6 = "7dcfff";
        #bright7 = "c0caf5";
      };
      */
    };
  };
}
