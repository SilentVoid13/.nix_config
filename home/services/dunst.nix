{pkgs, ...}: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus Dark";
      package = pkgs.papirus-icon-theme;
      size = "16x16";
    };
    settings = {
      global = {
        monitor = 0;
        width = 300;
        height = 200;
        origin = "top-right";
        shrink = "yes";
        transparency = 10;
        padding = 16;
        horizontal_padding = 16;
        frame_width = 3;
        format = "<b>%s</b>\\n%b";
        line_height = 4;
        idle_threshold = 120;
        markup = "full";
        alignment = "left";
        vertical_alignment = "center";
        icon_position = "left";
        word_wrap = "yes";
        ignore_newline = "no";
        show_indicators = "yes";
        sort = true;
        stack_duplicates = true;

        # handled by stylix
        #font = "Monospace 10";
      };
      urgency_low = {
        # handled by stylix
        #background = "#282c34";
        #foreground = "#dfdfdf";

        timeout = 4;
      };
      urgency_normal = {
        # handled by stylix
        #background = "#282c34";
        #foreground = "#dfdfdf";

        timeout = 4;
      };
      urgency_critical = {
        # handled by stylix
        #background = "#282c34";
        #foreground = "#dfdfdf";
        #frame_color = "#ff6c6b";

        timeout = 10;
      };
    };
  };
}
