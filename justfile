home_non_nixos_full:
    home-manager switch --flake .#non_nixos_full --impure
home_nixos_full:
    home-manager switch --flake .#nixos_full
home_nixos_work:
    home-manager switch --flake .#nixos_work
nixos_dell:
    sudo nixos-rebuild switch --flake .#dell
nixos_thinkpad:
    sudo nixos-rebuild switch --flake .#thinkpad
nixos_vm:
    nix build .#nixosConfigurations.vm.config.system.build.vm
update:
    nix-channel --update
    nix flake update
