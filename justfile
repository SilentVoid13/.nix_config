build_all:
    nix build .#homeConfigurations.work.activationPackage
    nix build .#homeConfigurations.full.activationPackage
    nix build .#nixosConfigurations.faye.config.system.build.toplevel --show-trace 
    nix build .#nixosConfigurations.jet.config.system.build.toplevel
    nix build .#nixosConfigurations.vm.config.system.build.toplevel
home_init target *args:
    # e.g. home_init nixos_full
    nix run home-manager/master -- switch --flake "{{target}}" {{args}}
home target *args:
    # full, work, full_non_nixos
    home-manager switch --flake "path://${PWD}#{{target}}" --impure -L {{args}}
nixos target *args:
    sudo nixos-rebuild switch --flake "path://${PWD}#{{target}}" -L {{args}}
update:
    nix-channel --update
    nix flake update
home_depends target pkg:
    nix why-depends --derivation .#homeConfigurations.{{target}}.activationPackage .\#homeConfigurations.{{target}}.pkgs.{{pkg}} --impure
nixos_depends target pkg:
    nix why-depends --derivation .#nixosConfigurations.{{target}}.config.system.build.toplevel .\#nixosConfigurations.{{target}}.config.system.packages.{{pkg}} --impure
run_vm:
    nixos-rebuild build-vm --flake .#vm
