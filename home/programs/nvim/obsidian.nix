{
  config,
  pkgs,
  lib,
  ...
}: let
in {
  programs.nixvim = {
    plugins.obsidian = {
      enable = true;
      workspaces = [
        {
          name = "resources";
          path = "${config.home.homeDirectory}/.resources";
        }
      ];
      disableFrontmatter = true;
      dailyNotes = {
        folder = "03.1 - Daily Notes";
        dateFormat = "%Y-%m-%d";
        template = "Resources/Templates/TEMPLATE Daily Note.md";
      };
      mappings = {
        gf = {
          action = "require('obsidian').util.gf_passthrough";
          opts = {
            noremap = false;
            expr = true;
            buffer = true;
          };
        };
        gl = {
          action = "require('obsidian').util.toggle_checkbox";
          opts.buffer = true;
        };
      };
      followUrlFunc = ''
        function(url)
              vim.fn.jobstart({"xdg-open", url})
        end
      '';
    };

    keymaps = [
      {
        mode = "n";
        key = "go";
        action = "<cmd>ObsidianQuickSwitch<CR>";
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>ObsidianToday<CR>";
      }
    ];
  };
}
