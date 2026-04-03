{ inputs, ... }:
let
  nixpkgs = inputs.nixpkgs;
  pkgs-stable = import inputs.nixpkgs-stable { system = "x86_64-linux"; };
in
{
  flake.nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [
          (self: super: { lldb = pkgs-stable.lldb; })
          inputs.niri.overlays.niri
        ];
      }
      (
        { pkgs, modulesPath, ... }:
        {
          imports = [
            "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
            "${modulesPath}/installer/cd-dvd/channel.nix"
          ];

          i18n.defaultLocale = "en_US.UTF-8";
          time.timeZone = "Europe/Paris";

          networking = {
            wireless.enable = false;
            networkmanager.enable = true;
          };

          programs.zsh.enable = true;

          environment.systemPackages = with pkgs; [
            git
            neovim
          ];
        }
      )
    ];
    specialArgs = { };
  };
}
