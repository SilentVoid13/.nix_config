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

    maps.normal = {
      "<leader>gs" = "<cmd>Git";
      "<leader>gp" = "<cmd>Git('push')";
      "<leader>gl" = "<cmd>Git({'pull', '--rebase')";
      "<leader>gt" = "<cmd>Git({'push', '-u', 'origin')";
    };
  };
}
