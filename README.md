# .nix_config

This repository contains my Nix configuration for both my NixOS and non-NixOS machines.
It is based on the [flake-parts](https://github.com/hercules-ci/flake-parts) [dendritic pattern](https://github.com/mightyiam/dendritic).

Main components:
- [hosts](https://github.com/SilentVoid13/.nix_config/tree/master/modules/hosts): configuration for each of my machines
- [features](https://github.com/SilentVoid13/.nix_config/tree/master/modules/features): mostly contains the [home-manager](https://github.com/nix-community/home-manager) configuration for all of my programs/services. This is compatible with non-NixOS systems.
- [nixos](https://github.com/SilentVoid13/.nix_config/tree/master/modules/nixos): mostly contains the NixOS modules used for my different NixOS machines.
- [nvim](https://github.com/SilentVoid13/.nix_config/tree/master/modules/features/editor/nvim): my Neovim configuration completely managed with Nix using [nixvim](https://github.com/nix-community/nixvim)
