{
  myconf,
  nixpkgs,
  nixpkgs-stable,
  lanzaboote,
  disko,
  ...
}: let
    # TODO: do not hardcode system
    pkgs-stable = import nixpkgs-stable {
        system = "x86_64-linux";
    };
in {
  dell = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      lanzaboote.nixosModules.lanzaboote
      disko.nixosModules.disko
      ../nixos/configuration.nix
      ../nixos/dell
      ../disko/luks_lvm_swap.nix
    ];
    specialArgs = {
      inherit myconf nixpkgs pkgs-stable;
      disk_name = "/dev/nvme0n1";
    };
  };

  thinkpad = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      lanzaboote.nixosModules.lanzaboote
      disko.nixosModules.disko
      ../nixos/configuration.nix
      ../nixos/thinkpad
      ../disko/luks_lvm_swap.nix
    ];
    specialArgs = {
      inherit myconf nixpkgs pkgs-stable;
      disk_name = "/dev/nvme0n1";
    };
  };

  # Used to test a nixos config in a QEMU VM
  #vm = nixpkgs.lib.nixosSystem {
  #  system = "x86_64-linux";
  #  modules = [
  #    ../nixos/configuration.nix
  #    ../nixos/vm
  #  ];
  #  specialArgs = {inherit myconf;};
  #};

  # Used to build a custom NixOS ISO
  iso = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../nixos/configuration_iso.nix
    ];
    specialArgs = {};
  };
}
