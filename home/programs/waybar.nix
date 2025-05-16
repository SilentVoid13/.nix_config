{ ... }:
{
  programs.waybar = {
    enable = true;
    # TODO: try to nixGL wrap?
    #package =
    settings = {
      mainBar = {
        ipc = true;
        layer = "bottom";
        position = "top";
        height = 30;
        spacing = 15;
        #modules-left = ["hyprland/workspaces" "hyprland/submap"];
        #modules-center = ["hyprland/window"];
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "disk"
          "memory"
          "cpu"
          "battery"
          "clock"
          "tray"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
        };
        "sway/mode" = {
          "format" = "<span style=\"italic\">{}</span>";
        };
        "tray" = {
          "spacing" = 10;
        };
        "clock" = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };
        "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = false;
        };
        "memory" = {
          "format" = "{used:0.1f}GiB/{total:0.1f}GiB ";
        };
        "battery" = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "pulseaudio" = {
          "scroll-step" = 5;
          "format" = "{volume}% {icon}  {format_source}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-source" = "Mic ON";
          "format-source-muted" = "Mic OFF";
          "format-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
            ];
          };
          "on-click" = "pavucontrol";
        };
        "disk" = {
          "interval" = 60;
          "format" = "{used}/{total}";
          "path" = "/";
        };
        "idle_inhibitor" = {
          "format" = "{icon} ";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
      };
    };

    # https://github.com/Alexays/Waybar/issues/3492
    # https://github.com/Alexays/Waybar/issues/3750
    style = ''
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
      }

      window#waybar {
          background-color: alpha(black, 0.5);
          color: white;
      }

      #window {
          font-weight: bold;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-top: 2px solid transparent;
      }

      #workspaces button.focused {
          color: #c9545d;
          border-top: 2px solid #c9545d;
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #clock {
          font-weight: bold;
      }

      #battery {
      }

      #battery icon {
          color: red;
      }

      #battery.charging {
      }

      #battery.warning:not(.charging) {
          color: white;
      }

      #cpu {
      }

      #memory {
      }

      #pulseaudio {
      }

      #pulseaudio.muted {
      }

      #tray {
      }
    '';
  };
}
