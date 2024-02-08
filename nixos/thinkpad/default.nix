{
  inputs,
  system,
  pkgs,
  lib,
  myconf,
  config,
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

  # LUKS partition
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/c883467b-222e-4a61-97ee-6d71cd682f34";
      preLVM = true;
    };
  };

  networking = {
    hostName = "faye";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  hardware.bluetooth.enable = true;

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
    # Bluetooth
    blueman.enable = true;
    # Keyring
    gnome.gnome-keyring.enable = true;
    # Yubikey
    pcscd.enable = true;
    # Mount, trash, and other functionalities
    gvfs.enable = true;
    # Thumbnail support for images
    tumbler.enable = true;
    # VPN
    mullvad-vpn.enable = true;
    # Flatpak
    flatpak.enable = true;
  };

  virtualisation.docker.enable = true;

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
    docker-compose
    clang
  ];
}
