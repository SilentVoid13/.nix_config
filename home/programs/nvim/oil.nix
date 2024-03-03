{
  config,
  pkgs,
  lib,
  ...
}: let
in {
  programs.nixvim = {
    plugins.oil = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Oil<CR>";
      }
    ];
  };
}
