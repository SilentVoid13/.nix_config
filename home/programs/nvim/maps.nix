{...}: {
  programs.nixvim = {
    enable = true;

    keymaps = [
      # quickfix next/prev
      {
        mode = "n";
        key = "<leader>fj";
        action = "<cmd>cnext<CR>";
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>cprev<CR>";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>cclose<CR>";
      }
      {
        mode = "n";
        key = "^";
        action = "<C-^>";
      }
      {
        # Copy to clipboard
        mode = "v";
        key = "<leader>cp";
        action = "\"+y";
      }
    ];
  };
}
