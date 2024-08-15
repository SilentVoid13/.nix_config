{
  pkgs,
  lib,
  myconf,
  nixpkgs,
  ...
}: {
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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.bluetooth.enable = true;

  networking.extraHosts = ''
    207.180.211.147 contabo
    192.168.0.99 homelab
  '';

  nix = {
    package = pkgs.nixVersions.latest;
    settings.allowed-users = ["${myconf.username}"];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
    # use existing nixpkgs for commands like nix-shell
    registry.nixpkgs.flake = nixpkgs;
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock = {};
  };

  # containers / virtualisation
  virtualisation.docker.enable = true;
  programs.firejail.enable = true;

  xdg = {
    portal = {
      enable = true;
      config.common = {
        # https://github.com/emersion/xdg-desktop-portal-wlr?tab=readme-ov-file#running
        default = ["gtk"];
        "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
        "org.freedesktop.impl.portal.Screencast" = ["wlr"];
      };
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

  programs = {
    _1password = {
      enable = true;
    };
    _1password-gui = {
      enable = true;
      #package = pkgs._1password-gui-beta;
      polkitPolicyOwners = ["${myconf.username}"];
    };
    nix-ld.enable = true;
    adb.enable = true;
    noisetorch.enable = true;
    dconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-volman];
    };
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
