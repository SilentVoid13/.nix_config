{
  pkgs,
  lib,
  ...
}: let
  helpers = import ./helpers.nix {inherit lib;};

  # find_command doesn't support pipe so we create a tmp script as a bypass
  file_lister = pkgs.writeShellScriptBin "file_lister" ''
    folder=$1
    if [[ -z $1 ]]; then
        folder="."
    fi
    rg --files | proximity-sort "''${folder}"
  '';

  find_command =
    /*
    lua
    */
    ''
      function()
          return { "file_lister", vim.fn.expand('%')  }
      end
    '';

  tiebreak_index_fn =
    /*
    lua
    */
    ''function(entry1, entry2, prompt) return entry1.index < entry2.index; end'';
in {
  home.packages = with pkgs; [
    # ripgrep is required for live_grep and grep_string
    ripgrep
    proximity-sort
    file_lister
  ];

  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>fO" = {
          action = "git_files";
        };
        "<leader>fs" = {
          action = "live_grep";
        };
        "<leader>fb" = {
          action = "buffers";
        };
      };
      settings = {
        pickers.find_files = {
          find_command = helpers.mkRaw find_command;
        };
      };
      extensions = {
        fzf-native = {
          enable = true;
          settings = {
            override_file_sorter = true;
            override_generic_sorter = true;
          };
        };
      };
    };
    plugins.web-devicons = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>fo";
        action = "<cmd>lua require('telescope.builtin').find_files({ tiebreak = ${tiebreak_index_fn}, })<CR>";
      }
    ];
  };
}
