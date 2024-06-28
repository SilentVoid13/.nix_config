{...}: {
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
    #./programs/steam.nix
    ./programs/superprod.nix

    ##  Terminal
    ./programs/git
    #./programs/alacritty.nix
    ./programs/foot.nix
    ./programs/nvim
    ./programs/gdb.nix
    ./programs/lldb.nix
    ./programs/zsh
    #./programs/fish.nix
    ./programs/tmux

    ## OS
    ./programs/sway
    #./programs/wofi.nix
    ./programs/fuzzel.nix
    ./programs/waybar.nix
    ./services/dunst.nix
    ./services/darkman.nix
  ];

  # TODO: remove this
  home.sessionPath = ["$HOME/H/r/dojo_rs/target/release"];
}
