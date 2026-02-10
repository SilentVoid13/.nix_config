{
  pkgs,
  lib,
  myconf,
  nixpkgs,
  inputs,
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
      pkiBundle = "/var/lib/sbctl";
    };
    loader.systemd-boot.enable = lib.mkForce false;
    # use bleeding edge kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [ "ntfs" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.bluetooth.enable = true;

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
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };
  programs.firejail.enable = true;

  networking.networkmanager.wifi.powersave = false;

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

    # make non-nixos things slightly less painful
    envfs.enable = true;
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

    # make non-nixos things slightly less painful
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
      ];
    };
    noisetorch.enable = true;
    dconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs; [ thunar-volman ];
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
    android-tools
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

  ## niri config
  imports = [
    inputs.niri.nixosModules.niri
  ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  # programs.uwsm = {
  #   enable = true;
  #   waylandCompositors = {
  #     niri = {
  #       prettyName = "niri";
  #       comment = "niri compositor managed by UWSM";
  #       binPath = "/run/current-system/sw/bin/niri";
  #     };
  #   };
  # };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
        # pkgs.xdg-desktop-portal-wlr
      ];
      config = {
        common = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
        };
      };
      ## WLR config
      # config.common = {
      #   # https://github.com/emersion/xdg-desktop-portal-wlr?tab=readme-ov-file#running
      #   default = [ "gtk" ];
      #   "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      #   "org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
      # };
      # wlr.enable = true;
    };
  };
}
