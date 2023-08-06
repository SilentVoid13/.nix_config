{
  config,
  pkgs,
  ...
}: let
in {
    home.packages = with pkgs; [
        nodejs_20
        nodePackages_latest.pnpm
    ];
}
