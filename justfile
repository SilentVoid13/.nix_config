non_nixos_full:
    home-manager switch --flake .#non_nixos_full --impure
nixos_full:
    home-manager switch --flake .#nixos_full
nixos_work:
    home-manager switch --flake .#nixos_work
dell:
    sudo nixos-rebuild switch --flake .#thinkpad
thinkpad:
    sudo nixos-rebuild switch --flake .#thinkpad
vm:
    nix build .#nixosConfigurations.vm.config.system.build.vm
update:
    nix-channel --update
    nix flake update
