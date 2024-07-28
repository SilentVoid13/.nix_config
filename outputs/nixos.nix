{
  myconf,
  nixpkgs,
  lanzaboote,
  ...
}: {
  dell = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      lanzaboote.nixosModules.lanzaboote
      ../nixos/configuration.nix
      ../nixos/dell
    ];
    specialArgs = {inherit myconf nixpkgs;};
  };

  thinkpad = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      lanzaboote.nixosModules.lanzaboote
      ../nixos/configuration.nix
      ../nixos/thinkpad
    ];
    specialArgs = {inherit myconf nixpkgs;};
  };

  # Used to test a nixos config in a QEMU VM
  vm = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../nixos/configuration.nix
      ../nixos/vm
    ];
    specialArgs = {inherit myconf;};
  };

  # Used to build a custom NixOS ISO
  iso = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../nixos/configuration_iso.nix
    ];
    #specialArgs = {};
  };
}
