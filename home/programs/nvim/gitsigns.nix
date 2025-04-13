{...}: let
in {
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      settings = {
        sign_priority = 100;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "]c";
        action = "<cmd>Gitsigns nav_hunk next<CR>";
      }
      {
        mode = "n";
        key = "[c";
        action = "<cmd>Gitsigns nav_hunk prev<CR>";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>Gitsigns setqflist all<CR>";
      }
      {
        mode = "n";
        key = "<leader>hs";
        action = "<cmd>Gitsigns stage_hunk<CR>";
      }
      {
        mode = "n";
        key = "<leader>hS";
        action = "<cmd>Gitsigns stage_buffer<CR>";
      }
      {
        mode = "n";
        key = "<leader>hr";
        action = "<cmd>Gitsigns reset_hunk<CR>";
      }
      {
        mode = "n";
        key = "<leader>hR";
        action = "<cmd>Gitsigns reset_buffer<CR>";
      }
    ];
  };
}
