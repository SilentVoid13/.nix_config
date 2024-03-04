{
  config,
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
        key = "gf";
        action = "function() require('my_obsidian').follow_closest_link() end";
        lua = true;
      }
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
