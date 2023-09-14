non_nixos_full:
    home-manager switch --flake .#non_nixos_full --impure
nixos_full:
    home-manager switch --flake .#nixos_full
update:
    nix flake update
    just home
vm:
    nix build .#nixosConfigurations.vm.config.system.build.vm
