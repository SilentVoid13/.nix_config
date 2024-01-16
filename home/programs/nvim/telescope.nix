{
  config,
  pkgs,
  lib,
  ...
}: let
  helpers = import ./helpers.nix {inherit lib;};

  # find_command doesn't support pipe so we create a tmp script as a bypass
  file_lister = pkgs.writeShellScriptBin "file_lister" ''
    rg --files | proximity-sort $1
  '';

  find_command = ''
    function()
        return { "file_lister", vim.fn.expand('%')  }
    end
  '';

  tiebreak_index_fn = ''function(entry1, entry2, prompt) return entry1.index < entry2.index; end'';
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
        "<leader>fd" = {
          action = "git_files";
        };
        "<leader>fs" = {
          action = "live_grep";
        };
        "<leader>fb" = {
          action = "buffers";
        };
      };
      extraOptions = {
        pickers.find_files = {
          find_command = helpers.mkRaw find_command;
        };
      };
      extensions = {
        fzf-native = {
          enable = true;
          overrideFileSorter = true;
          overrideGenericSorter = true;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua require('telescope.builtin').find_files({ tiebreak = ${tiebreak_index_fn}, })<CR>";
      }
    ];
  };
}
