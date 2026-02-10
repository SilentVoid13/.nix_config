{ pkgs, ... }:
let
  lock_cmd = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
in
{
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
    events = {
      "before-sleep" = lock_cmd;
      # "lock" = lock_cmd;
    };
  };
}
