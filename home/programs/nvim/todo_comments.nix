{...}: {
  programs.nixvim = {
    plugins.todo-comments = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>dt";
        action = "<cmd>TodoTelescope<CR>";
      }
    ];
  };
}
