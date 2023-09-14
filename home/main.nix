{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [

    ## Common
    ./programs/common_terminal.nix
    ./programs/common_gui.nix
    ./programs/common_toolchain.nix
    ./programs/common_hacking.nix

    ## GUI
    ./programs/1password.nix
    #./programs/brave.nix
    ./programs/firefox.nix
    ./programs/binaryninja
    ./programs/mpv.nix
    ./programs/steam.nix

    ##  Terminal
    ./programs/git
    #./programs/alacritty.nix
    ./programs/foot.nix
    inputs.nixvim.homeManagerModules.nixvim
    ./programs/nvim
    ./programs/gdb.nix
    ./programs/zsh.nix
    ./programs/tmux.nix
    ./programs/nodejs.nix

    ## OS
    ./programs/sway
    #./programs/wofi.nix
    ./programs/fuzzel.nix
    ./programs/waybar.nix
    ./services/dunst.nix
  ];
}
