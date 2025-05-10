{
  pkgs,
  lib,
  myconf,
  nixpkgs,
  ...
}:
{
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
    # use bleeding edge kernel
    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [ "ntfs" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.bluetooth.enable = true;

  networking.extraHosts = ''
    192.168.0.99 homelab
    ${myconf.extra_hosts}
  '';

  nix = {
    package = pkgs.nixVersions.latest;
    settings.allowed-users = [ "${myconf.username}" ];
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
  };

  # containers / virtualisation
  virtualisation.docker.enable = true;
  programs.firejail.enable = true;

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
    # Bluetooth
    blueman.enable = true;
    # Keyring
    gnome.gnome-keyring.enable = true;
    # Yubikey
    pcscd.enable = true;

    # File Manager
    gvfs.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;
    # VPN
    mullvad-vpn.enable = true;
    # Flatpak
    flatpak.enable = true;
    kanata = {
      enable = true;
      keyboards.mykeebs = {
        devices = [
          "/dev/input/by-id/usb-Kinesis_Kinesis_Adv360_360555127546-if01-event-kbd"
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = builtins.readFile ./files/homerow.kbd;
      };
    };
  };

  services.udev.packages = with pkgs; [
    vial
  ];

  programs = {
    _1password = {
      enable = true;
    };
    _1password-gui = {
      enable = true;
      #package = pkgs._1password-gui-beta;
      polkitPolicyOwners = [ "${myconf.username}" ];
    };
    nix-ld.enable = true;
    adb.enable = true;
    noisetorch.enable = true;
    dconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-volman ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    just
    sbctl
    yubioath-flutter
    docker-compose
    vial
  ];

  ## wayland config

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    _JAVA_AWT_WM_NONREPARENTING = 1;
    NIXOS_OZONE_WL = 1;
    #WLR_NO_HARDWARE_CURSORS = 1;
    #GBM_BACKEND = "nvidia-drm";
    #NVD_BACKEND = "direct";
    #LIBVA_DRIVER_NAME = "nvidia";
    #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
    #__GL_VRR_ALLOWED = 0;
    #__GL_SYNC_TO_VBLANK = 0;
    #__GL_GSYNC_ALLOWED = 0;
  };

  ## hyprland config
  #programs.hyprland.enable = true;
  #security.pam.services.hyprlock = {};

  ## sway config
  security.pam.services.swaylock = { };
  #programs.sway.enable = true;
  xdg.portal = {
    enable = true;
    config.common = {
      # https://github.com/emersion/xdg-desktop-portal-wlr?tab=readme-ov-file#running
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
    };
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
