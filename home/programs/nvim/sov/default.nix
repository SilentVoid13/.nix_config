{myconf, ...}: {
  home.sessionPath = ["$HOME/H/p/sov/target/debug"];

  programs.nixvim = {
    extraFiles = {"lua/my_sov.lua" = builtins.readFile ./my_sov.lua;};

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
        action = "function() require('my_sov').new_note() end";
        lua = true;
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
        action = "function() require(\"markdown\").toggle_checkbox() end";
        lua = true;
      }
      {
        mode = "n";
        key = "o";
        action = "function() require(\"markdown\").new_line_below() end";
        lua = true;
      }
      {
        mode = "n";
        key = "O";
        action = "function() require(\"markdown\").new_line_above() end";
        lua = true;
      }
      {
        mode = "i";
        key = "<Tab>";
        action = "function() require(\"markdown\").jump() end";
        lua = true;
      }
      {
        mode = "i";
        key = "<CR>";
        action = "function() require(\"markdown\").new_line_below() end";
        lua = true;
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
