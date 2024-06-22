{
  config,
  pkgs,
  lib,
  nixGLWrap,
  ...
}: let
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
    '';
  };

  wallpaper_switcher = "sway/wallpaper_switcher.sh";
  wallpaper_switcher_path = "${config.xdg.dataHome}/${wallpaper_switcher}";
  reboot_wallpaper = "sway/reboot_wallpaper.sh";
  reboot_wallpaper_path = "${config.xdg.dataHome}/${reboot_wallpaper}";

  #mon1 = "HDMI-A-1";
  mon1 = "DP-2";
  mon2 = "eDP-1";

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
in {
  # TODO: dunst dependency?
  # TODO: fuzzel dependency?
  # TODO: darkman dependency?

  home.packages = with pkgs; [
    configure-gtk
    polkit_gnome
    libnotify
    wl-clipboard
    brightnessctl
    playerctl
    grim
    slurp
    wbg
    (nixGLWrap wdisplays)
    xdg-utils
    networkmanagerapplet
    pulseaudio
    pavucontrol
    # GTK stuff
    glib
    gsettings-desktop-schemas
    gnome-themes-extra
    gnome.adwaita-icon-theme
  ];

  services.swayidle = {
    enable = true;
  };

  xdg = {
    enable = true;
    dataFile."${wallpaper_switcher}".source = ./wallpaper_switcher.sh;
    dataFile."${reboot_wallpaper}".source = ./reboot_wallpaper.sh;
  };

  home.file.".xkb/symbols/qwerty_fr" = {
    source = ./qwerty_fr.xkb;
  };

  wayland.windowManager.sway = {
    enable = true;
    # https://github.com/nix-community/home-manager/issues/5311
    checkConfig = false;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/foot";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      fonts = {
        names = ["Pango" "Monospace"];
        size = 8.0;
      };
      bars = [];
      defaultWorkspace = "workspace number ${ws1}";
      input = {
        "type:keyboard" = {
          xkb_layout = "qwerty_fr";
        };
        #"type:touchpad" = {
        #  tap = "enabled";
        #  natural_scroll = "enabled";
        #};
      };
      startup = [
        {
          command = ''
            ${pkgs.swayidle}/bin/swayidle -w \
            timeout 300 'swaylock -f -c 000000' \
            timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
            before-sleep 'swaylock -f -c 000000'
          '';
        }
        {command = "nm-applet --indicator";}
        {command = "${wallpaper_switcher_path}";}
        # TODO: does this work on non-nixos?
        {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
        #{command = "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1";}
        {command = "${pkgs.waybar}/bin/waybar";}
        {command = "${pkgs.darkman}/bin/darkman run";}
      ];

      keybindings = let
        m = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPause" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl s 5%+";
          "Next" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          "${m}+Shift+q" = "kill";
          "${m}+Left" = "focus left";
          "${m}+Right" = "focus right";
          "${m}+Up" = "focus up";
          "${m}+Down" = "focus down";
          "${m}+h" = "focus left";
          "${m}+l" = "focus right";
          "${m}+k" = "focus up";
          "${m}+j" = "focus down";
          "${m}+Shift+Left" = "move left";
          "${m}+Shift+Right" = "move right";
          "${m}+Shift+Up" = "move up";
          "${m}+Shift+Down" = "move down";
          "${m}+Shift+h" = "move left";
          "${m}+Shift+l" = "move right";
          "${m}+Shift+k" = "move up";
          "${m}+Shift+j" = "move down";
          "${m}+v" = "split v";
          "${m}+Shift+v" = "split h";
          "${m}+f" = "fullscreen toggle";
          "${m}+s" = "layout stacking";
          "${m}+t" = "layout tabbed";
          "${m}+e" = "layout toggle split";
          "${m}+Shift+f" = "floating toggle";
          "${m}+space" = "focus mode_toggle";
          #"${m}+q" = "focus parent";
          #"${m}+d" = "focus child";
          "${m}+1" = "workspace number ${ws1}";
          "${m}+2" = "workspace number ${ws2}";
          "${m}+3" = "workspace number ${ws3}";
          "${m}+4" = "workspace number ${ws4}";
          "${m}+5" = "workspace number ${ws5}";
          "${m}+6" = "workspace number ${ws6}";
          "${m}+7" = "workspace number ${ws7}";
          "${m}+8" = "workspace number ${ws8}";
          "${m}+9" = "workspace number ${ws9}";
          "${m}+0" = "workspace number ${ws10}";
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
          "${m}+Shift+r" = "reload";
          "${m}+r" = "mode \"resize\"";
          "${m}+Print" = "mode \"system\"";
          "Print" = "mode \"screenshot\"";
          "${m}+b" = "exec firefox";
          "${m}+d" = "exec ${config.wayland.windowManager.sway.config.menu}";
          "${m}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal} tmux new -As0";
          "${m}+Shift+w" = "exec ${reboot_wallpaper_path}";
          "${m}+p" = "exec playerctl play-pause";
          "${m}+o" = "exec playerctl previous";
          "${m}+i" = "exec playerctl next";
          "${m}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
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
          l = "exec swaylock -f -c 000000, mode default";
          s = "exec systemctl suspend, mode default";
          r = "exec systemctl reboot, mode default";
          h = "exec systemctl poweroff, mode default";
        };
        screenshot = {
          Escape = "mode default";
          Return = "mode default";
          "1" = "exec grim -g \"$(slurp)\" - | wl-copy, mode default";
          "2" = "exec env GRIM_DEFAULT_DIR=$HOME/.screenshots grim -g \"$(slurp)\", mode default";
          "3" = "exec grim - | wl-copy, mode default";
          "4" = "exec env GRIM_DEFAULT_DIR=$HOME/.screenshots grim, mode default";
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
    };
    extraConfig = ''
      focus output ${mon1}

      default_border none
      for_window [app_id="pavucontrol"] floating enable, border normal
      for_window [app_id="qalculate-gtk"] floating enable, border normal
      for_window [app_id="imv"] floating enable, border normal
    '';
  };
}
