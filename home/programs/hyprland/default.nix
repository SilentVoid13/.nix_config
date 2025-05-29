{
  pkgs,
  myconf,
  ...
}:
let
  mon1 = myconf.monitor1;
  mon2 = myconf.monitor2;
in
{
  home.file.".xkb/symbols/qwerty_fr" = {
    source = "${pkgs.qwerty-fr}/share/X11/xkb/symbols/us_qwerty-fr";
  };

  home.packages = with pkgs; [
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
  ];

  services.hyprpaper.enable = pkgs.lib.mkForce false;

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "${pkgs.hyprlock}/bin/hyprlock";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
        }
        {
          timeout = 320;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 10;
      };
      background = {
        color = "rgb(282828)";
      };
      input-field = [
        {
          monitor = "";
          size = "500, 50";
          outline_thickness = 0;
          inner_color = "rgb(458588)";
          font_color = "rgb(282828)";
          fail_color = "rgb(cc241d)";
          fade_on_empty = false;
          placeholder_text = ''Password:'';
          dots_spacing = 0.3;
          dots_center = true;
          position = "0, -80";
        }
      ];
      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 50;
          color = "rgb(83a598)";
          position = "0, 150";
          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 20;
          color = "rgb(83a598)";
          position = "0, 50";
          valign = "center";
          halign = "center";
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [
        "${mon1},3840x2160@120,0x0,1.5"
        "${mon2},1920x1080@165,2560x0,1"
      ];
      input = {
        kb_layout = "qwerty_fr";
      };
      exec-once = [
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "${pkgs.waybar}/bin/waybar"
        "nm-applet --indicator"
      ];
      bind = [
        "SUPER,Return,exec,${pkgs.foot}/bin/foot tmux new -As0"
        "SUPER,D,exec,${pkgs.fuzzel}/bin/fuzzel"
        "SUPERSHIT,D,exec,bemoji -t"
        "SUPER,B,exec,firefox"
        "SUPER,P,exec,playerctl play-pause"
        "SUPER,O,exec,playerctl previous"
        "SUPER,I,exec,playerctl next"

        "SUPER,F,fullscreen,0"
        "SUPER,Q,killactive,"

        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"
        "SUPER,H,movefocus,l"
        "SUPER,L,movefocus,r"
        "SUPER,K,movefocus,u"
        "SUPER,J,movefocus,d"
        "SUPERSHIFT,left,movewindow,l"
        "SUPERSHIFT,right,movewindow,r"
        "SUPERSHIFT,up,movewindow,u"
        "SUPERSHIFT,down,movewindow,d"
        "SUPERSHIFT,H,movewindow,l"
        "SUPERSHIFT,L,movewindow,r"
        "SUPERSHIFT,K,movewindow,u"
        "SUPERSHIFT,J,movewindow,d"

        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"
        "SUPER,0,workspace,0"
        "SUPERSHIFT,1,movetoworkspacesilent,1"
        "SUPERSHIFT,2,movetoworkspacesilent,2"
        "SUPERSHIFT,3,movetoworkspacesilent,3"
        "SUPERSHIFT,4,movetoworkspacesilent,4"
        "SUPERSHIFT,5,movetoworkspacesilent,5"
        "SUPERSHIFT,6,movetoworkspacesilent,6"
        "SUPERSHIFT,7,movetoworkspacesilent,7"
        "SUPERSHIFT,8,movetoworkspacesilent,8"
        "SUPERSHIFT,9,movetoworkspacesilent,9"
        "SUPERSHIFT,0,movetoworkspacesilent,0"

        # media controls
        ",XF86AudioRaiseVolume,exec,${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,exec,${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ",XF86AudioMute,exec,${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioPlay,exec,${pkgs.playerctl}/bin/playerctl play-pause"
        ",XF86AudioPause,exec,${pkgs.playerctl}/bin/playerctl play-pause"
        ",XF86AudioNext,exec,${pkgs.playerctl}/bin/playerctl next"
        ",XF86AudioPrev,exec,${pkgs.playerctl}/bin/playerctl previous"
        ",XF86MonBrightnessDown,exec,${pkgs.brightnessctl}/bin/brightnessctl s 5%-"
        ",XF86MonBrightnessUp,exec,${pkgs.brightnessctl}/bin/brightnessctl s 5%+"
        ",Next,exec,${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle"

        # modes
        "SUPER,R,submap,resize"
        ",Print,submap,screenshot"
        "SUPER,Print,submap,system"
      ];
      workspace = [
        "1,monitor:${mon1},default:true"
        "2,monitor:${mon1},default:true"
        "3,monitor:${mon1},default:true"
        "9,monitor:${mon2},default:true"
      ];
      dwindle = {
        no_gaps_when_only = 1;
      };
      xwayland = {
        force_zero_scaling = true;
      };
      cursor.no_hardware_cursors = true;
    };
    extraConfig = ''
      submap = resize
      binde =,L,resizeactive,10 0
      binde =,H,resizeactive,-10 0
      binde =,K,resizeactive,0 -10
      binde =,J,resizeactive,0 10
      bind =,escape,submap,reset
      submap = reset

      submap = screenshot
      binde =,1,exec,${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | wl-copy
      binde =,1,submap,reset
      binde =,2,exec,env GRIM_DEFAULT_DIR=$HOME/.screenshots ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\"
      binde =,2,submap,reset
      binde =,3,exec,${pkgs.grim}/bin/grim - | wl-copy
      binde =,3,submap,reset
      binde =,4,exec,env GRIM_DEFAULT_DIR=$HOME/.screenshots ${pkgs.grim}/bin/grim
      binde =,4,submap,reset
      bind =,escape,submap,reset
      submap = reset

      submap = system
      binde =,l,exec,${pkgs.hyprlock}/bin/hyprlock --immediate
      binde =,l,submap,reset
      binde =,s,exec,systemctl suspend
      binde =,s,submap,reset
      binde =,r,exec,systemctl reboot
      binde =,r,submap,reset
      binde =,h,exec,systemctl poweroff
      binde =,h,submap,reset
      bind =,escape,submap,reset
      submap = reset
    '';
  };
}
