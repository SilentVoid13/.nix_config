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
        action = "<cmd>Git";
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>Git('push')";
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>Git({'pull', '--rebase')";
      }
      {
        mode = "n";
        key = "<leader>gt";
        action = "<cmd>Git({'push', '-u', 'origin')";
      }
    ];
  };
}
