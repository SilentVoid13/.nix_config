{inputs, myconf, ...}: let
  nixpkgs = inputs.nixpkgs;
in {
  dell = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.lanzaboote.nixosModules.lanzaboote
      ../nixos/configuration.nix
      ../nixos/dell
    ];
    specialArgs = { inherit myconf; };
  };

  thinkpad = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.lanzaboote.nixosModules.lanzaboote
      ../nixos/configuration.nix
      ../nixos/thinkpad
    ];
    specialArgs = { inherit myconf; };
  };

  # Used to test a nixos config in a QEMU VM
  vm = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../nixos/configuration.nix
      ../nixos/vm
    ];
    specialArgs = { inherit myconf; };
  };
}

#{inputs, ...}: let
#  mkConfig = {
#    system,
#    nixpkgs,
#    modules,
#  }: let
#    pkgs = import inputs.nixpkgs {
#      inherit system;
#      config.allowUnfree = true;
#    };
#  in
#    nixpkgs.lib.nixosSystem {inherit system pkgs modules;};
#
#  nixpkgs = inputs.nixpkgs;
#in {
#  dell = mkConfig {
#    system = "x86_64-linux";
#    inherit nixpkgs;
#    modules = [
#      ../nixos/configuration.nix
#      ../nixos/dell
#    ];
#  };
#
#  vm = mkConfig {
#    system = "x86_64-linux";
#    inherit nixpkgs;
#    modules = [
#      ../nixos/configuration.nix
#      ../nixos/vm
#    ];
#  };
#}
