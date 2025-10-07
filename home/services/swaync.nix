{ ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";

      control-center-width = 400;
      control-center-height = 660;
      control-center-positionX = "center";
      control-center-positionY = "center";
      fit-to-screen = false;

      widgets = [
        "buttons-grid"
        "title"
        "dnd"
        "notifications"
      ];
      "widget-config" = {
        "buttons-grid" = {
          "actions" = [
            {
              "label" = "󰐥";
              "command" = "systemctl poweroff";
            }
            {
              "label" = "󰜉";
              "command" = "systemctl reboot";
            }
            {
              "label" = "󰕾";
              "command" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
              "type" = "toggle";
            }
            {
              "label" = "󰍬";
              "command" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
              "type" = "toggle";
            }
            {
              "label" = "󰂯";
              "command" = "blueman-manager";
            }
          ];
        };
      };
    };
    style = ''
      .notification {
        margin: 6px 12px;
        padding: 2px;
      }

      .notification-content {
         background: transparent;
         padding: 5px;
      }

      scrolledwindow {
        overflow: hidden;
      }

      scrollbar {
        -GtkScrollbar-has-backward-stepper: 0;
        -GtkScrollbar-has-forward-stepper: 0;
        min-width: 0;
        min-height: 0;
        background: none;
        border: none;
      }

      scrollbar slider {
        background: none;
        border: none;
      }

      scrollbar,
      scrollbar slider {
        opacity: 0;
      }
    '';
  };
}
