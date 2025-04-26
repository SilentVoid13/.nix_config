{ myconf, ... }:
{
  home.sessionPath = [ "$HOME/H/p/sov/target/debug" ];

  programs.nixvim = {
    extraFiles."lua/my_sov.lua".source = ./my_sov.lua;

    keymaps = [
      # https://github.com/SilentVoid13/sov
      {
        mode = "n";
        key = "<leader>rd";
        action = "<cmd>SovDaily<CR>";
      }
      {
        mode = "n";
        key = "<leader>re";
        action.__raw = "function() require('my_sov').new_note() end";
      }
      {
        mode = "n";
        key = "<leader>rd";
        action = "<cmd>SovDaily<CR>";
      }
      {
        mode = "n";
        key = "<leader>ro";
        action = "<cmd>SovFindFiles<CR>";
      }
      {
        mode = "n";
        key = "<leader>rs";
        action = "<cmd>SovFuzzySearch<CR>";
      }
      # https://github.com/ixru/nvim-markdown
      {
        mode = "n";
        key = "<leader>rl";
        action.__raw = "function() require(\"markdown\").toggle_checkbox() end";
      }
      {
        mode = "n";
        key = "o";
        action.__raw = "function() require(\"markdown\").new_line_below() end";
      }
      {
        mode = "n";
        key = "O";
        action.__raw = "function() require(\"markdown\").new_line_above() end";
      }
      {
        mode = "i";
        key = "<Tab>";
        action.__raw = "function() require(\"markdown\").jump() end";
      }
      {
        mode = "i";
        key = "<CR>";
        action.__raw = "function() require(\"markdown\").new_line_below() end";
      }
    ];

    extraConfigLua = ''
      -- Disable default key mappings
      vim.g.vim_markdown_no_default_key_mappings = 1
      -- LaTeX math
      vim.g.vim_markdown_math = 1

      require("sov").setup({
        root_dir = '${myconf.knowledge_base}'
      })
    '';
  };
}
