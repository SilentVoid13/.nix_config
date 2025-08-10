home_init target *args:
    # e.g. home_init nixos_full
    nix run home-manager/master -- switch --flake "{{target}}" {{args}}
home target *args:
    # full, work, full_non_nixos
    home-manager switch --flake "path://${PWD}#{{target}}" --impure {{args}}
nixos target *args:
    sudo nixos-rebuild switch --flake "path://${PWD}#{{target}}" {{args}}
update:
    nix-channel --update
    nix flake update
home_depends target pkg:
    nix why-depends --derivation .#homeConfigurations.{{target}}.activationPackage .\#homeConfigurations.{{target}}.pkgs.{{pkg}} --impure
