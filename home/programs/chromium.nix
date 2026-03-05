{ pkgs, ... }:
{
  # NOTE: the actual config is in nixos/programs/chromium.nix
  # this is just to install the package
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
  };
}
