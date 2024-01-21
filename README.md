# .nix_config

This repository contains my Nix configuration for both my NixOS and non-NixOS machines.

The two main components are the following:
- [home](https://github.com/SilentVoid13/.dotfiles_nix/tree/master/home): contains the [home-manager](https://github.com/nix-community/home-manager) configuration for all of my services/programs. This is compatible with non-NixOS systems
- [nixos](https://github.com/SilentVoid13/.dotfiles_nix/tree/master/nixos): contains the NixOS configuration for my different machines

## Misc
- [nvim](https://github.com/SilentVoid13/.dotfiles_nix/tree/master/home/programs/nvim): my Neovim configuration completely managed with Nix using [nixvim](https://github.com/nix-community/nixvim)
- [nixos_install.sh](https://github.com/SilentVoid13/.dotfiles_nix/blob/master/nixos_install.sh): a script to automate the fresh installation of NixOS with LVM on LUKS encryption
