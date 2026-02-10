{
  myconf,
  nixpkgs,
  nixpkgs-stable,
  lanzaboote,
  disko,
  inputs,
  ...
}:
let
  # TODO: do not hardcode system
  pkgs-stable = import nixpkgs-stable {
    system = "x86_64-linux";
  };
in
{
  jet = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      (import ./config_pkgs.nix {
        inherit pkgs-stable;
        niri = inputs.niri;
      })
      lanzaboote.nixosModules.lanzaboote
      disko.nixosModules.disko
      ../nixos/configuration.nix
      ../nixos/jet
      ../disko/luks_lvm_swap.nix
      (if builtins.pathExists ../extra/nixos.nix then import ../extra/nixos.nix else { })
    ];
    specialArgs = {
      inherit
        myconf
        nixpkgs
        pkgs-stable
        inputs
        ;
      disk_name = "/dev/nvme0n1";
    };
  };

  faye = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      (import ./config_pkgs.nix {
        inherit pkgs-stable;
        niri = inputs.niri;
      })
      lanzaboote.nixosModules.lanzaboote
      disko.nixosModules.disko
      ../nixos/configuration.nix
      ../nixos/faye
      ../disko/luks_lvm_swap.nix
      (if builtins.pathExists ../extra/nixos.nix then import ../extra/nixos.nix else { })
    ];
    specialArgs = {
      inherit
        myconf
        nixpkgs
        pkgs-stable
        inputs
        ;
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
      (import ./config_pkgs.nix {
        inherit pkgs-stable;
      })
      ../nixos/configuration_iso.nix
    ];
    specialArgs = { };
  };
}
