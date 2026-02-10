{ pkgs, ... }:
let
  wallpaper_folder = "$HOME/.wallpapers";

  reboot_wallpaper = pkgs.writeShellScriptBin "reboot_wallpaper.sh" ''
    pkill -TERM -f ${pkgs.swaybg}/bin/swaybg
    pkill -TERM -f wallpaper_switcher
    ~/.local/share/sway/wallpaper_switcher.sh &
  '';

  wallpaper_switcher = pkgs.writeShellScriptBin "wallpaper_switcher.sh" ''
    wallpaper_folder="${wallpaper_folder}"
    delay=3600
    wallpaper=""

    random_wallpaper() {
        wallpaper=$(find $wallpaper_folder -maxdepth 1 -regex ".*\.\(jpg\|png\|jpeg\)" | shuf -n1)
    }

    while true 
    do
        random_wallpaper
        ${pkgs.swaybg}/bin/swaybg -i $wallpaper -m fill &
        last_pid=$!
        sleep 3600
        kill $last_pid
    done
  '';
in
{
  home.packages = [
    pkgs.swaybg
    wallpaper_switcher
    reboot_wallpaper
  ];
}
