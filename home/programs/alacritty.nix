{
  config,
  pkgs,
  ...
}: let
in {
  home.packages = with pkgs; [
    _1password-gui
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font = {
        normal = {
          family = "Terminus";
          size = 10;
        };
      };
      colors = {
        primary = {
          background = "#000000";
          foreground = "#fce8c3";
        };
        normal = {
          black = "#000000";
          red = "#ef2f27";
          green = "#519f50";
          yellow = "#fbb829";
          blue = "#2c78bf";
          magenta = "#e02c6d";
          cyan = "#0aaeb3";
          white = "#d0bfa1";
        };
        bright = {
          black = "#918175";
          red = "#f75341";
          green = "#98bc37";
          yellow = "#fed06e";
          blue = "#68a8e4";
          magenta = "#ff5c8f";
          cyan = "#53fde9";
          white = "#fce8c3";
        };
      };
      selection.save_to_clipboard = true;
      hints.enabled = [
        {
          regex = ''(mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001F\u007F-\u009F<>"\\s{-}\\^⟨⟩`]+'';
          command = "xdg-open";
          post_processing = true;
          mouse.enabled = true;
        }
      ];
    };
  };
}
