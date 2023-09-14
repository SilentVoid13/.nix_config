home:
    home-manager switch --flake .#nonix_full --impure
update:
    nix flake update
    just home
vm:
    nix build .#nixosConfigurations.vm.config.system.build.vm
