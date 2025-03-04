home_init target *args:
    # e.g. home_init nixos_full
    nix run home-manager/master -- switch --flake "{{target}}" {{args}}
home target *args:
    # full, work, full_non_nixos
    home-manager switch --flake ".#{{target}}" --impure {{args}}
nixos target *args:
    # dell, thinkpad, vm, iso
    sudo nixos-rebuild switch --flake ".#{{target}}" {{args}}
update:
    nix-channel --update
    nix flake update
