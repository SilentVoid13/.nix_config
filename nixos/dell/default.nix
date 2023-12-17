{
  inputs,
  system,
  pkgs,
  lib,
  myconf,
  ...
}: let
in {
  imports = [
    ./hardware-configuration.nix
  ];

  #boot = {
  #  loader = {
  #    systemd-boot.enable = true;
  #    efi.canTouchEfiVariables = true;
  #  };
  #};

  # lanzaboote currently replaces the systemd-boot module
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader.systemd-boot.enable = lib.mkForce false;
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/d79de524-1db9-4e58-a318-ff80db3ea5c3";
      preLVM = true;
    };
  };

  networking = {
    hostName = "jet";
  };

  hardware.opengl.enable = true;

  nix = {
    package = pkgs.nixUnstable;
    # todo: check what allowed-users is
    settings.allowed-users = ["${myconf.username}"];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  security = {
    polkit.enable = true;
    # For swaylock
    # https://nixos.wiki/wiki/Sway#Swaylock_cannot_unlock_with_correct_password
    pam.services.swaylock.text = ''
      # PAM configuration file for the swaylock screen locker. By default, it includes
      # the 'login' configuration file (see /etc/pam.d/login)
      auth include login
    '';
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    gnome.gnome-keyring.enable = true;
    # Yubikey
    pcscd.enable = true;
    # Mount, trash, and other functionalities
    gvfs.enable = true;
    # Thumbnail support for images
    tumbler.enable = true;
    # VPN
    mullvad-vpn.enable = true;
  };

  programs = {
    _1password = {
      enable = true;
    };
    _1password-gui = {
      enable = true;
      package = pkgs._1password-gui-beta;
      polkitPolicyOwners = ["${myconf.username}"];
    };
    adb.enable = true;
    noisetorch.enable = true;
    dconf.enable = true;

    thunar.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    just
    sbctl
    yubioath-flutter
    swaylock
  ];
}
