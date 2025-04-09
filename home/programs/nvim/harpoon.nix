{...}: let
in {
  programs.nixvim = {
    plugins.harpoon = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>'";
        action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
      }
      {
        mode = "n";
        key = "<leader>m";
        action.__raw = "function() require'harpoon':list():add() end";
      }
      {
        mode = "n";
        key = "'a";
        action.__raw = "function() require'harpoon':list():select(1) end";
      }
      {
        mode = "n";
        key = "'s";
        action.__raw = "function() require'harpoon':list():select(2) end";
      }
      {
        mode = "n";
        key = "'d";
        action.__raw = "function() require'harpoon':list():select(3) end";
      }
      {
        mode = "n";
        key = "'f";
        action.__raw = "function() require'harpoon':list():select(4) end";
      }
      {
        mode = "n";
        key = "'q";
        action.__raw = "function() require'harpoon':list():select(5) end";
      }
      {
        mode = "n";
        key = "'w";
        action.__raw = "function() require'harpoon':list():select(6) end";
      }
      {
        mode = "n";
        key = "'e";
        action.__raw = "function() require'harpoon':list():select(7) end";
      }
      {
        mode = "n";
        key = "'r";
        action.__raw = "function() require'harpoon':list():select(8) end";
      }
    ];
  };
}
