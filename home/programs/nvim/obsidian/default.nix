{
  config,
  myconf,
  pkgs,
  lib,
  ...
}: let
in {
  programs.nixvim = {
    extraFiles = {"lua/my_obsidian.lua" = builtins.readFile ./my_obsidian.lua;};

    plugins.obsidian = {
      enable = true;
      # For now, we use our custom version
      package = pkgs.emptyFile;

      workspaces = [
        {
          name = "knowledge_base";
          path = "${myconf.knowledge_base}";
        }
      ];
      disableFrontmatter = true;
      dailyNotes = {
        folder = "03.1 - Daily Notes";
        dateFormat = "%Y-%m-%d";
        template = "Resources/Templates/TEMPLATE Daily Note.md";
      };
      mappings = {
        fl = {
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
        key = "fd";
        action = "function() require('my_obsidian').follow_closest_link() end";
        lua = true;
      }
      {
        mode = "n";
        key = "ft";
        action = "function() require('my_obsidian').create_new_note() end";
        lua = true;
      }
      {
        mode = "n";
        key = "fo";
        action = "<cmd>ObsidianQuickSwitch<CR>";
      }
      {
        mode = "n";
        key = "fs";
        action = "<cmd>ObsidianSearch<CR>";
      }
      {
        mode = "n";
        key = "fD";
        action = "<cmd>ObsidianToday<CR>";
      }
    ];
  };
}
