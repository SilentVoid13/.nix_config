{...}: {
  programs.nixvim = {
    enable = true;

    keymaps = [
      {
        # Copy to clipboard
        mode = "v";
        key = "<leader>cp";
        action = "\"+y<CR>";
      }
    ];
  };
}
