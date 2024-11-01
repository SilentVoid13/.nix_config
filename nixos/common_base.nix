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
    supportedFilesystems = ["ntfs"];
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
    # Mount, trash, and other functionalities
    gvfs.enable = true;
    # Thumbnail support for images
    tumbler.enable = true;
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

        config = ''
          (defsrc
            caps a s d f j k l ;
          )
          (defvar
            tap-time 150
            hold-time 200
          )
          (defalias
            escctrl (tap-hold 100 100 esc lctl)
            a (tap-hold $tap-time $hold-time a lmet)
            s (tap-hold $tap-time $hold-time s lalt)
            d (tap-hold $tap-time $hold-time d lctl)
            f (tap-hold $tap-time $hold-time f lsft)
            j (tap-hold $tap-time $hold-time j rsft)
            k (tap-hold $tap-time $hold-time k rctl)
            l (tap-hold $tap-time $hold-time l ralt)
            ; (tap-hold $tap-time $hold-time ; rmet)
          )
          (deflayer base
            @escctrl @a @s @d @f @j @k @l @;
          )
        '';
      };
    };
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
