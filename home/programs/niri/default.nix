{
  pkgs,
  config,
  myconf,
  ...
}:
let
  m = "Mod";
  term = "${pkgs.foot}/bin/foot";
  menu = "otter_toggle_sway.sh";

  mon1 = myconf.monitor1;
  mon2 = myconf.monitor2;

  ws1 = "browser";
  ws2 = "terminal";
  ws9 = "external";

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
      '';
  };

in
{
  home.packages = with pkgs; [
    configure-gtk
    polkit_gnome
    qwerty-fr
    libnotify
    wl-clipboard
    brightnessctl
    playerctl
    xdg-utils
    networkmanagerapplet
    pulseaudio
    pavucontrol
    # GTK stuff
    glib
    adwaita-icon-theme
    gsettings-desktop-schemas
    gnome-themes-extra

    xwayland-satellite
  ];

  home.file.".xkb/symbols/qwerty_fr" = {
    source = "${pkgs.qwerty-fr}/share/X11/xkb/symbols/us_qwerty-fr";
  };

  # Fix swayidle service dependencies for Niri/Wayland session
  # systemd.user.services.swayidle.after = [ "xdg-desktop-autostart.target" ];

  # NOTE: in addition, we need to modify:
  # - waybar to enable niri/workspaces
  # - zsh to start it from .zprofile
  # - common_base.nix to enable nixos niri (portal etc)

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    settings = {
      xwayland-satellite.enable = true;

      outputs = {
        "${mon1}" = {
          focus-at-startup = true;
          mode.width = 3840;
          mode.height = 2160;
          mode.refresh = 120.0;
          position.x = 0;
          position.y = 0;
          scale = 1.5;
        };
        "${mon2}" = {
          position.x = 2560;
          position.y = 0;
        };
      };

      workspaces = {
        "${ws1}" = {
          open-on-output = "${mon1}";
        };
        "${ws2}" = {
          open-on-output = "${mon1}";
        };
        "${ws9}" = {
          open-on-output = "${mon2}";
        };
      };

      layout = {
        gaps = 0;
        focus-ring.width = 0;
        border.width = 1;
        default-column-width = { };
      };

      input.keyboard.xkb.layout = "qwerty_fr";
      prefer-no-csd = true;

      binds = {
        # program binds
        "${m}+b".action.spawn = [
          "firefox"
        ];
        "${m}+e".action.spawn = [
          "${menu}"
        ];
        # "${m}+Shift+e".action.spawn = [
        #   "bemoji"
        #   "-t"
        # ];
        "${m}+Return".action.spawn = [
          "${term}"
          "tmux"
          "new"
          "-As0"
        ];
        # "${m}+Shift+w".action.spawn = [
        #   "${reboot_wallpaper_path}"
        # ];
        "${m}+p".action.spawn = [
          "${pkgs.playerctl}/bin/playerctl"
          "play-pause"
        ];
        "${m}+o".action.spawn = [
          "${pkgs.playerctl}/bin/playerctl"
          "previous"
        ];
        "${m}+i".action.spawn = [
          "${pkgs.playerctl}/bin/playerctl"
          "next"
        ];
        "${m}+c".action.spawn = [
          "swaync-client"
          "-t"
          "-sw"
        ];
        "${m}+Shift+c".action.spawn = [
          "swaync-client"
          "-C"
        ];
        "XF86AudioRaiseVolume".action.spawn = [
          "${pkgs.pulseaudio}/bin/pactl"
          "set-sink-volume"
          "@DEFAULT_SINK@"
          "+5%"
        ];
        "XF86AudioLowerVolume".action.spawn = [
          "${pkgs.pulseaudio}/bin/pactl"
          "set-sink-volume"
          "@DEFAULT_SINK@"
          "-5%"
        ];
        "XF86AudioMute".action.spawn = [
          "${pkgs.pulseaudio}/bin/pactl"
          "set-sink-mute"
          "@DEFAULT_SINK@"
          "toggle"
        ];
        "XF86AudioPlay".action.spawn = [
          "${pkgs.playerctl}/bin/playerctl"
          "play-pause"
        ];
        "XF86AudioPause".action.spawn = [
          "${pkgs.playerctl}/bin/playerctl"
          "play-pause"
        ];
        "XF86AudioNext".action.spawn = [
          "${pkgs.playerctl}/bin/playerctl"
          "next"
        ];
        "XF86AudioPrev".action.spawn = [
          "${pkgs.playerctl}/bin/playerctl"
          "previous"
        ];
        "XF86MonBrightnessDown".action.spawn = [
          "${pkgs.brightnessctl}/bin/brightnessctl"
          "s"
          "5%-"
        ];
        "XF86MonBrightnessUp".action.spawn = [
          "${pkgs.brightnessctl}/bin/brightnessctl"
          "s"
          "5%+"
        ];
        "Insert".action.spawn = [
          "${pkgs.pulseaudio}/bin/pactl"
          "set-source-mute"
          "@DEFAULT_SOURCE@"
          "toggle"
        ];
        "${m}+Shift+Print".action.screenshot = { };
        "${m}+Print".action.screenshot-window = { };
        "${m}+Shift+s".action.spawn = [
          "systemctl"
          "suspend"
        ];

        # workspaces
        "${m}+a".action.focus-workspace = "${ws1}";
        "${m}+s".action.focus-workspace = "${ws2}";
        "${m}+d".action.focus-workspace = 3;
        "${m}+f".action.focus-workspace = 4;
        "${m}+g".action.focus-workspace = 5;
        "${m}+h".action.focus-workspace = 6;
        "${m}+j".action.focus-workspace = 7;
        "${m}+k".action.focus-workspace = 8;
        "${m}+l".action.focus-workspace = "${ws9}";
        "${m}+SemiColon".action.focus-workspace = 10;
        "${m}+Shift+1".action.move-window-to-workspace = "${ws1}";
        "${m}+Shift+2".action.move-window-to-workspace = "${ws2}";
        "${m}+Shift+3".action.move-window-to-workspace = 3;
        "${m}+Shift+4".action.move-window-to-workspace = 4;
        "${m}+Shift+5".action.move-window-to-workspace = 5;
        "${m}+Shift+6".action.move-window-to-workspace = 6;
        "${m}+Shift+7".action.move-window-to-workspace = 7;
        "${m}+Shift+8".action.move-window-to-workspace = 8;
        "${m}+Shift+9".action.move-window-to-workspace = "${ws9}";
        "${m}+Shift+0".action.move-window-to-workspace = 10;

        # niri
        "${m}+Shift+e".action.quit = { };
        "${m}+q".action.close-window = { };
        "${m}+shift+h".action.focus-column-left = { };
        "${m}+shift+l".action.focus-column-right = { };
        "${m}+shift+j".action.focus-window-down = { };
        "${m}+shift+k".action.focus-window-up = { };
        "${m}+shift+v".action.maximize-column = { };
        "${m}+v".action.fullscreen-window = { };
        "${m}+space".action.toggle-window-floating = { };
        "${m}+WheelScrollUp".action.focus-window-up = { };
        "${m}+WheelScrollDown".action.focus-window-down = { };
        "${m}+WheelScrollRight".action.focus-column-right = { };
        "${m}+WheelScrollLeft".action.focus-column-left = { };
      };

      spawn-at-startup = [
        # {
        #   argv = [
        #     "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        #   ];
        # }
        {
          argv = [
            "${pkgs.waybar}/bin/waybar"
          ];
        }
        {
          argv = [
            "${pkgs.networkmanagerapplet}/bin/nm-applet"
            "--indicator"
          ];
        }
        {
          argv = [
            "wallpaper_switcher.sh"
          ];
        }
      ];

      window-rules = [
        {
          open-floating = true;
          matches = [
            { app-id = "otter-launcher"; }
            { app-id = "pavucontrol"; }
            { app-id = "qalculate-gtk"; }
            { app-id = "imv"; }
          ];
        }
        {
          open-maximized = true;
          # FIXME: not merged yet
          # open-maximized-to-edges = true;
          matches = [
            { app-id = "foot"; }
            { app-id = "firefox"; }
          ];
        }
      ];
    };
  };
}
