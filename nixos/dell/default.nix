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
      device = "/dev/disk/by-uuid/d79de524-1db9-4e58-a318-ff80db3ea5c3";
      preLVM = true;
    };
  };

  networking = {
    hostName = "jet";
    extraHosts = ''
      207.180.211.147 contabo
      192.168.0.99 homeserver
    '';
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Nvidia PRIME
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:0:1:0";
      intelBusId = "PCI:0:2:0";
    };
  };

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
  ];
}
