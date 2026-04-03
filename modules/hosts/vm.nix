{
  self,
  inputs,
  lib,
  withSystem,
  ...
}:
{
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    pkgs = withSystem "x86_64-linux" ({ pkgs, ... }: pkgs);
    system = "x86_64-linux";
    modules = [
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

      # Home-manager as NixOS module for VM
      inputs.home-manager.nixosModules.home-manager

      # VM-specific configuration
      (
        { pkgs, modulesPath, ... }:
        {
          imports = [
            (modulesPath + "/virtualisation/qemu-vm.nix")
          ];

          networking.hostName = "vm";

          # VM boot (no lanzaboote)
          boot = {
            loader.systemd-boot.enable = true;
            kernelPackages = pkgs.lib.mkForce pkgs.linuxPackages_latest;
          };

          # QEMU settings
          virtualisation = {
            cores = 4;
            memorySize = 4096;
            qemu.options = [
              "-enable-kvm"
              "-device virtio-vga-gl"
              "-display gtk,gl=on"
            ];
            diskSize = 8192;
          };

          # Auto-login for testing
          services.getty.autologinUser = self.myconf.username;

          # Home-manager integration
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${self.myconf.username} = {
              imports = [
                {
                  home.stateVersion = "23.05";
                }
                self.modules.homeManager.chromium
                self.modules.homeManager.foot
                self.modules.homeManager.zsh
                self.modules.homeManager.tmux
                self.modules.homeManager.nvim
                self.modules.homeManager.git
                self.modules.homeManager.ssh
                self.modules.homeManager.niri
                self.modules.homeManager.waybar
                self.modules.homeManager.swayidle
                self.modules.homeManager.swaync
                self.modules.homeManager.wallpaper
                self.modules.homeManager.idle-inhibit
                self.modules.homeManager.mpv
                self.modules.homeManager.htop
              ];
            };
          };
        }
      )
    ];
  };

  perSystem =
    { ... }:
    {
      apps.vm = {
        type = "app";
        program = "${inputs.self.nixosConfigurations.vm.config.system.build.vm}/bin/run-vm-vm";
      };
    };
}
