{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Paris";

  networking = {
    # incompatible with networkmanager
    wireless.enable = false;
    networkmanager.enable = true;
  };

  programs = {
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];
}
