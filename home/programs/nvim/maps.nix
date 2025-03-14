{...}: {
  programs.nixvim = {
    enable = true;

    keymaps = [
      {
        # quickfix next
        mode = "n";
        key = "<leader>fj";
        action = "<cmd>cnext<CR>";
      }
      {
        # quickfix prev
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>cprev<CR>";
      }
      {
        # close quickfix
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>cclose<CR>";
      }
      {
        # go back to last buffer
        mode = "n";
        key = "^";
        action = "<C-^>";
      }
      {
        # copy to clipboard
        mode = "v";
        key = "<leader>cp";
        action = "\"+y";
      }
      {
        # tmp buffer
        # FIXME: this is not working
        mode = "v";
        key = "<leader>t";
        action = "<cmd>enew<CR>";
      }
    ];
  };
}
