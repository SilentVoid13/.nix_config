{
  config,
  pkgs,
  lib,
  specialArgs,
  ...
}: let
  wallpaper_switcher = "sway/wallpaper_switcher.sh";
  wallpaper_switcher_path = "${config.xdg.dataHome}/${wallpaper_switcher}";
  reboot_wallpaper = "sway/reboot_wallpaper.sh";
  reboot_wallpaper_path = "${config.xdg.dataHome}/${reboot_wallpaper}";

  mon1 = "HDMI-A-1";
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
  # TODO: xkb-qwerty-fr
  # TODO: polkit-gnome
  # TODO: dunst dependency?

  #imports = import [
  #  ../fuzzel.nix
  #];

  home.packages = with pkgs; [
    #polkit_gnome
    #xwayland
    wl-clipboard
    brightnessctl
    playerctl
    grim
    slurp
    wbg
    (specialArgs.nixGLWrap wdisplays)
    xdg-utils
    networkmanagerapplet
    pavucontrol
    darkman
    gsettings-qt
  ];

  services.swayidle = {
    enable = true;
  };

  # TODO: PAM problem, requires /etc/pam.d/swaylock which requires nixOS
  # https://nixos.wiki/wiki/Sway#Swaylock_cannot_unlock_with_correct_password
  #programs.swaylock = {
  #  enable = true;
  #};

  xdg = {
    enable = true;
    dataFile."${wallpaper_switcher}".source = ./wallpaper_switcher.sh;
    dataFile."${reboot_wallpaper}".source = ./reboot_wallpaper.sh;
    # TODO: portal
    #portal = {
    #  enable = true;
    #  wlr.enable = true;
    #  extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];
    #};

    dataFile."dark-mode.d/gtk-theme.sh" = {
      executable = true;
      text = ''
        gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      '';
    };
    dataFile."dark-mode.d/desktop-notif.sh" = {
      executable = true;
      text = ''notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night "switching to dark mode"'';
    };
    dataFile."light-mode.d/gtk-theme.sh" = {
      executable = true;
      text = ''
        gsettings set org.gnome.desktop.interface gtk-theme Adwaita
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
      '';
    };
    dataFile."light-mode.d/desktop-notif.sh" = {
      executable = true;
      text = ''notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night "switching to light mode"'';
    };
  };

  # TODO: audio, bluetooth
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  pulse.enable = true;
  #};

  wayland.windowManager.sway = {
    enable = true;
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
          xkb_layout = "us";
          xkb_variant = "qwerty-fr";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
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
        {command = "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1";}
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
          "${m}+m" = "split h";
          "${m}+v" = "split v";
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
          res = "1920 1080";
          #scale = "1.2";
        };
        "${mon2}" = {
          pos = "1900 0";
          res = "2240 1400";
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
