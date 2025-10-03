{ pkgs, ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "overlay";
      layer-shell = true;
      fit-to-screen = true;
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "notifications"
      ];
    };
  };
}
