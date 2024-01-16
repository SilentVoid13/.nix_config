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
        action = "<cmd>Git<CR>";
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>Git('push')<CR>";
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>Git({'pull', '--rebase')<CR>";
      }
      {
        mode = "n";
        key = "<leader>gt";
        action = "<cmd>Git({'push', '-u', 'origin')<CR>";
      }
    ];
  };
}
