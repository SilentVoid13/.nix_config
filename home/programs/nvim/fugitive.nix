{
  config,
  pkgs,
  ...
}: let
in {
  programs.nixvim = {
    plugins.fugitive = {
      enable = true;
    };

    keymaps = [
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
        key = "<leader>gt";
        action = "<cmd>tab Git push -u origin<CR>";
      }
    ];
  };
}
