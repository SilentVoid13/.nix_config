{
  inputs,
  system,
  pkgs,
  ...
}: let
in {
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4096; # Use 2048MiB memory.
      cores = 4;
      #graphics = false;
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Install home-manager config
  imports = [
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.jdoe = import ../../home/full.nix;
        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
      }
  ];
}
