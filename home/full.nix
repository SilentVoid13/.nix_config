{...}: {
  imports = [
    ## Common
    ./programs/common_terminal.nix
    ./programs/common_gui.nix
    ./programs/common_toolchain.nix
    ./programs/common_hacking.nix

    ## GUI
    #./programs/brave.nix
    ./programs/firefox.nix
    ./programs/binaryninja
    ./programs/ida
    ./programs/caido
    ./programs/mpv.nix
    ./programs/steam.nix
    ./programs/superprod.nix

    ##  Terminal
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
    #./programs/sway
    ./programs/hyprland

    #./programs/wofi.nix
    ./programs/fuzzel.nix
    ./programs/waybar.nix
    ./services/dunst.nix
    ./services/darkman.nix
  ];
}
