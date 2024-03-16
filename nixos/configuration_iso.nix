{
  inputs,
  pkgs,
  ...
}: let
in {
  nixpkgs.config.allowUnfree = true;

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Paris";

  networking = {
    networkmanager.enable = true;
  };

  programs = {
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    nvim
  ];
}
