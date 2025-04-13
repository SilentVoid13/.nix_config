{...}: let
in {
  programs.nixvim = {
    plugins.fugitive.enable = true;

    keymaps = [
      # fugitive
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>tab Git<CR>";
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>tab Git push<CR>";
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>tab Git pull --rebase<CR>";
      }
      {
        mode = "n";
        key = "<leader>go";
        action = "<cmd>tabnew|Gclog<CR>";
      }
      {
        mode = "n";
        key = "<leader>gm";
        action = "<cmd>Git mergetool<CR>";
      }
    ];
  };
}
