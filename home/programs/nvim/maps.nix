{...}: {
  programs.nixvim = {
    enable = true;

    keymaps = [
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
