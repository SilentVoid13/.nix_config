home:
    home-manager switch --flake .#laptop --impure
update:
    nix flake update
    just home
