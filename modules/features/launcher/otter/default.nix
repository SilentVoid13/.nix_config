{ inputs, ... }:
{
  flake.modules.homeManager.otter-launcher =
    {
      pkgs,
      lib,
      ...
    }:
    let
      otter_toggle_sway = pkgs.writeShellScriptBin "otter_toggle_sway.sh" ''
        #!/bin/bash
        foot --app-id "otter-launcher" -T "otter-launcher" -e zsh -c "sleep 0.01 && otter-launcher"
      '';
    in
    {
      imports = [
        inputs.otter-launcher.homeModules.default
      ];

      home.packages = [
        otter_toggle_sway
        pkgs.sway-launcher-desktop
      ];

      programs.otter-launcher = {
        enable = true;
        settings = lib.importTOML ./_files/config.toml;
      };
    };
}
