{
  config,
  pkgs,
  pkgs-stable,
  lib,
  myconf,
  wayland-pipewire-idle-inhibit,
  ...
}:
let
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

  wallpaper_switcher = "sway/wallpaper_switcher.sh";
  wallpaper_switcher_path = "${config.xdg.dataHome}/${wallpaper_switcher}";
  reboot_wallpaper = "sway/reboot_wallpaper.sh";
  reboot_wallpaper_path = "${config.xdg.dataHome}/${reboot_wallpaper}";

  lock_cmd = "${pkgs.swaylock}/bin/swaylock -f -c 000000";

  mon1 = myconf.monitor1;
  mon2 = myconf.monitor2;

  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10";
in
{
  # TODO: dunst dependency?
  # TODO: fuzzel dependency?
  # TODO: darkman dependency?

  home.packages = with pkgs; [
    configure-gtk
    polkit_gnome
    qwerty-fr
    libnotify
    wl-clipboard
    brightnessctl
    playerctl
    grim
    slurp
    swaybg
    xdg-utils
    networkmanagerapplet
    pulseaudio
    pavucontrol
    # GTK stuff
    glib
    adwaita-icon-theme
    gsettings-desktop-schemas
    gnome-themes-extra

    # TODO: move this elsewhere
    ulauncher
  ];

  imports = [
    wayland-pipewire-idle-inhibit.homeModules.default
  ];

  programs.swaylock.enable = true;

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = lock_cmd;
      }
      {
        timeout = 320;
        command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"'';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = lock_cmd;
      }
      #{ event = "lock"; command = lock_cmd; }
    ];
  };

  services.wayland-pipewire-idle-inhibit = {
    enable = true;
    systemdTarget = "sway-session.target";
    settings = {
      verbosity = "WARN";
      media_minimum_duration = 5;
      idle_inhibitor = "wayland";
      sink_whitelist = [ ];
      node_blacklist = [
        { name = "spotify"; }
      ];
    };
  };

  xdg = {
    enable = true;
    dataFile."${wallpaper_switcher}".source = ./wallpaper_switcher.sh;
    dataFile."${reboot_wallpaper}".source = ./reboot_wallpaper.sh;
  };

  home.file.".xkb/symbols/qwerty_fr" = {
    source = "${pkgs.qwerty-fr}/share/X11/xkb/symbols/us_qwerty-fr";
  };

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    # https://github.com/nix-community/home-manager/issues/5311
    checkConfig = false;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/foot";
      # menu = "${pkgs.fuzzel}/bin/fuzzel";
      menu = "${pkgs.ulauncher}/bin/ulauncher-toggle";

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
          mode = "hide";
          hiddenState = "hide";
          position = "top";
          extraConfig = "modifier Mod4";
        }
      ];
      defaultWorkspace = "workspace number ${ws1}";
      input = {
        "type:keyboard" = {
          xkb_layout = "qwerty_fr";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          pointer_accel = "0.7";
        };
      };
      startup = [
        { command = "nm-applet --indicator"; }
        { command = "${wallpaper_switcher_path}"; }
        # TODO: does this work on non-nixos?
        { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
        { command = "${pkgs.ulauncher}/bin/ulauncher --hide-window"; }
      ];

      keybindings =
        let
          m = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          # program binds
          "${m}+b" = "exec firefox";
          "${m}+e" = "exec ${config.wayland.windowManager.sway.config.menu}";
          "${m}+Shift+e" = "exec bemoji -t";
          "${m}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal} tmux new -As0";
          "${m}+Shift+w" = "exec ${reboot_wallpaper_path}";
          "${m}+p" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "${m}+o" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "${m}+i" = "exec ${pkgs.playerctl}/bin/playerctl next";

          "${m}+q" = "kill";
          "${m}+v" = "fullscreen toggle";
          "${m}+Shift+f" = "floating toggle";
          "${m}+space" = "focus mode_toggle";

          # focus
          "${m}+Left" = "focus left";
          "${m}+Right" = "focus right";
          "${m}+Up" = "focus up";
          "${m}+Down" = "focus down";
          #"${m}+h" = "focus left";
          #"${m}+l" = "focus right";
          #"${m}+k" = "focus up";
          #"${m}+j" = "focus down";

          # move
          "${m}+Shift+Left" = "move left";
          "${m}+Shift+Right" = "move right";
          "${m}+Shift+Up" = "move up";
          "${m}+Shift+Down" = "move down";
          "${m}+Shift+h" = "move left";
          "${m}+Shift+l" = "move right";
          "${m}+Shift+k" = "move up";
          "${m}+Shift+j" = "move down";

          # layout
          #"${m}+v" = "split v";
          #"${m}+Shift+v" = "split h";
          "${m}+t" = "layout stacking";
          "${m}+w" = "layout toggle split";
          #"${m}+t" = "layout tabbed";

          # workspaces
          "${m}+a" = "workspace number ${ws1}";
          "${m}+s" = "workspace number ${ws2}";
          "${m}+d" = "workspace number ${ws3}";
          "${m}+f" = "workspace number ${ws4}";
          "${m}+g" = "workspace number ${ws5}";
          "${m}+h" = "workspace number ${ws6}";
          "${m}+j" = "workspace number ${ws7}";
          "${m}+k" = "workspace number ${ws8}";
          "${m}+l" = "workspace number ${ws9}";
          "${m}+SemiColon" = "workspace number ${ws10}";
          "${m}+Shift+1" = "move container to workspace number ${ws1}";
          "${m}+Shift+2" = "move container to workspace number ${ws2}";
          "${m}+Shift+3" = "move container to workspace number ${ws3}";
          "${m}+Shift+4" = "move container to workspace number ${ws4}";
          "${m}+Shift+5" = "move container to workspace number ${ws5}";
          "${m}+Shift+6" = "move container to workspace number ${ws6}";
          "${m}+Shift+7" = "move container to workspace number ${ws7}";
          "${m}+Shift+8" = "move container to workspace number ${ws8}";
          "${m}+Shift+9" = "move container to workspace number ${ws9}";
          "${m}+Shift+0" = "move container to workspace number ${ws10}";

          # media controls
          "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPause" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
          "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 5%+";
          "Insert" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          # modes
          "${m}+Shift+r" = "reload";
          "${m}+Shift+q" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
          "${m}+r" = "mode \"resize\"";
          "${m}+Print" = "mode \"system\"";
          "Print" = "mode \"screenshot\"";
        };

      modes = {
        resize = {
          Escape = "mode default";
          Return = "mode default";
          Down = "resize grow height 10 px";
          Left = "resize shrink width 10 px";
          Right = "resize grow width 10 px";
          Up = "resize shrink height 10 px";
          h = "resize shrink width 10 px";
          j = "resize grow height 10 px";
          k = "resize shrink height 10 px";
          l = "resize grow width 10 px";
        };
        system = {
          Escape = "mode default";
          Return = "mode default";
          l = "exec ${lock_cmd}, mode default";
          s = "exec systemctl suspend, mode default";
          r = "exec systemctl reboot, mode default";
          h = "exec systemctl poweroff, mode default";
        };
        screenshot = {
          Escape = "mode default";
          Return = "mode default";
          "1" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | wl-copy, mode default";
          "2" =
            "exec env GRIM_DEFAULT_DIR=$HOME/.screenshots ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\", mode default";
          "3" = "exec ${pkgs.grim}/bin/grim - | wl-copy, mode default";
          "4" = "exec env GRIM_DEFAULT_DIR=$HOME/.screenshots ${pkgs.grim}/bin/grim, mode default";
        };
      };

      workspaceOutputAssign = [
        {
          workspace = "${ws1}";
          output = "${mon1}";
        }
        {
          workspace = "${ws2}";
          output = "${mon1}";
        }
        {
          workspace = "${ws3}";
          output = "${mon1}";
        }
        {
          workspace = "${ws9}";
          output = "${mon2}";
        }
        {
          workspace = "${ws10}";
          output = "${mon2}";
        }
      ];

      output = {
        "${mon1}" = {
          pos = "0 0";
          res = "3840x2160@120.000Hz";
          scale = "1.5";
        };
        "${mon2}" = {
          pos = "2560 0";
          res = "1920x1080";
          #res = "2240 1400";
          #scale = "1.2";
        };
      };

      # gaps.smartGaps = true;
      # gaps.smartBorders = "on";
    };
    extraConfig = ''
      focus output ${mon1}
      bindswitch lid:on output ${mon2} disable
      bindswitch lid:off output ${mon2} enable

      default_border none
      for_window [app_id="pavucontrol"] floating enable, border normal
      for_window [app_id="qalculate-gtk"] floating enable, border normal
      for_window [app_id="imv"] floating enable, border normal
      for_window [app_id="thunar" title="^File Operation Progress$"] floating enable
      for_window [app_id="thunar" title="^Confirm to replace files$"] floating enable
      for_window [app_id="ulauncher"] floating enable, border none
    '';
  };
}
