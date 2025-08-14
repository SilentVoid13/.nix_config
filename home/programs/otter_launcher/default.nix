{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  otter_toggle_sway = pkgs.writeShellScriptBin "otter_toggle_sway.sh" ''
    #!/bin/bash

    if [ -z $(swaymsg -t get_tree | grep '"app_id": "otter-launcher"') ] 
    then
        foot --app-id "otter-launcher" -T "otter-launcher" -e sh -c "sleep 0.01 && otter-launcher"
    else
        if [ -z $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).app_id' | grep "otter-launcher") ];
    	then
    	    swaymsg [app_id="^otter-launcher$"] focus;
    	else
    	    swaymsg [app_id="^otter-launcher$"] kill;
        fi
    fi
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
    settings = lib.importTOML ./config.toml;
  };
}
