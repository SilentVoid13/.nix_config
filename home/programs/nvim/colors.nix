{...}: {
  programs.nixvim = {
    opts = {
      background = "dark";
    };

    match = {
      #Todo = "\\cTODO";
      Done = "\\cDONE";
    };

    highlight = {
      ColorColumn = {
        bg = "#555555";
      };
      SignColumn = {
        bg = "none";
      };
      CursorLineNR = {
        bg = "none";
      };
      Normal = {
        bg = "none";
      };
      #Todo = {
      #  ctermfg = "white";
      #  bg = "#FF1010";
      #  fg = "white";
      #};
      Done = {
        ctermfg = "white";
        bg = "#57BA37";
        fg = "white";
      };
    };

    colorschemes = {
      tokyonight = {
        enable = true;
        settings = {
          style = "night";
          dim_nactive = false;
          lualine_bold = false;
          transparent = true;
          styles = {
            comments = {
              italic = true;
            };
            keywords = {
              italic = true;
            };
            sidebars = "transparent";
            floats = "transparent";
          };
        };
      };

      gruvbox = {
        enable = false;
        settings = {
          contrast_dark = "hard";
          invert_selection = false;
        };
      };
    };
  };
}
