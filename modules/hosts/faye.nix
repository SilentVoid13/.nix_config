{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.modules.homeManager.faye =
    { ... }:
    {
      imports = [
        self.modules.homeManager.base

        ## GUI
        self.modules.homeManager.chromium
        self.modules.homeManager.firefox

        ## media
        self.modules.homeManager.mpv
        # self.modules.homeManager.steam
        # self.modules.homeManager.superprod

        ## terminal
        self.modules.homeManager.git
        self.modules.homeManager.ssh
        self.modules.homeManager.foot
        # self.modules.homeManager.alacritty
        self.modules.homeManager.zsh
        # self.modules.homeManager.fish
        self.modules.homeManager.tmux
        self.modules.homeManager.nvim
        self.modules.homeManager.htop

        ## wm
        self.modules.homeManager.niri
        # self.modules.homeManager.sway
        # self.modules.homeManager.hyprland
        self.modules.homeManager.stylix
        # self.modules.homeManager.darkman
        self.modules.homeManager.otter-launcher
        # self.modules.homeManager.fuzzel
        # self.modules.homeManager.wofi
        # self.modules.homeManager.sherlock
        self.modules.homeManager.waybar
        self.modules.homeManager.swayidle
        self.modules.homeManager.wallpaper
        self.modules.homeManager.idle-inhibit
        self.modules.homeManager.swaync
        # self.modules.homeManager.dunst
        self.modules.homeManager.syncthing

        ## reverse
        self.modules.homeManager.ida
        self.modules.homeManager.binaryninja
        self.modules.homeManager.ghidra
        self.modules.homeManager.caido
        self.modules.homeManager.jeb
        self.modules.homeManager.jadx
        self.modules.homeManager.gdb
        self.modules.homeManager.lldb
      ];
    };

  flake.homeConfigurations.work = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = withSystem "x86_64-linux" ({ pkgs, ... }: pkgs);
    modules = [
      self.modules.homeManager.faye
    ];
  };

  flake.nixosConfigurations.faye = inputs.nixpkgs.lib.nixosSystem {
    pkgs = withSystem "x86_64-linux" ({ pkgs, ... }: pkgs);
    modules = [
      ./_hardware/faye.nix

      self.modules.nixos.base-system
      self.modules.nixos.base-services
      self.modules.nixos.boot
      self.modules.nixos.nix-settings
      self.modules.nixos.audio
      self.modules.nixos.bluetooth
      self.modules.nixos.security
      self.modules.nixos.virtualisation
      self.modules.nixos.fonts
      self.modules.nixos.wayland
      self.modules.nixos.chromium
      self.modules.nixos.niri
      self.modules.nixos.stylix

      self.modules.nixos.disko-core
    ];
  };
}
