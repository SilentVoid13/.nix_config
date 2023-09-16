{
  inputs,
  system,
  pkgs,
  myconf,
  ...
}: let
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "jet";
    wireless.enable = true;
    useDHCP = true;
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  security = {
    polkit.enable = true;
    # For swaylock
    # https://nixos.wiki/wiki/Sway#Swaylock_cannot_unlock_with_correct_password
    security.pam.services.swaylock.text = ''
      # PAM configuration file for the swaylock screen locker. By default, it includes
      # the 'login' configuration file (see /etc/pam.d/login)
      auth include login
    '';
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  xdg = {
    enable = true;
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];
    };
  };

  programs = {
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["${myconf.username}"];
    };
    swaylock = {
      enable = true;
    };
  };
}
