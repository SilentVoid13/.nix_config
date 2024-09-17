home_init target:
    # e.g. home_init nixos_full
    nix run home-manager/master -- switch --flake "{{target}}"
home target:
    # full, work, full_non_nixos
    home-manager switch --flake ".#{{target}}" --impure
nixos target:
    # dell, thinkpad, vm, iso
    sudo nixos-rebuild switch --flake ".#{{target}}"
update:
    nix-channel --update
    nix flake update
