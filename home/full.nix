{ ... }:
{
  imports = [
    ## Common
    ./programs/common_terminal.nix
    ./programs/common_gui.nix

    ## GUI
    #./programs/brave.nix
    ./programs/firefox.nix
    ./programs/binaryninja
    ./programs/ida
    ./programs/ghidra.nix
    ./programs/caido
    ./programs/mpv.nix
    ./programs/steam.nix
    ./programs/superprod.nix

    ## Terminal
    ./programs/git
    ./programs/ssh.nix
    #./programs/alacritty.nix
    ./programs/foot.nix
    ./programs/nvim
    ./programs/gdb.nix
    ./programs/lldb.nix
    ./programs/zsh
    #./programs/fish.nix
    ./programs/tmux

    ## OS
    ./programs/stylix.nix
    ./programs/sway
    #./programs/hyprland
    ## launcher
    #./programs/wofi.nix
    ./programs/fuzzel.nix
    ./programs/otter_launcher
    # ./programs/sherlock.nix
    ./programs/waybar.nix
    ./services/dunst.nix
    #./services/darkman.nix
    ./services/syncthing.nix
  ];
}
