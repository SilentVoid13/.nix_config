{ pkgs, ... }:
let
  otter_pkg = pkgs.rustPlatform.buildRustPackage rec {
    pname = "otter-launcher";
    version = "v0.5.6";
    src = pkgs.fetchFromGitHub {
      owner = "kuokuo123";
      repo = pname;
      rev = version;
      sha256 = "sha256-Z5ZX9S+hmgMJZU3l20mlyX97hSMQQu8j5utARqbFnHs=";
    };
    cargoHash = "";
    doCheck = false;
    # FIXME: this is currently broken as it doesn't provide a Cargo.lock
  };

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
  home.packages = [
    otter_toggle_sway
    pkgs.sway-launcher-desktop
    # otter_pkg
  ];

  # xdg = {
  #   enable = true;
  #   configFile."otter-launcher/config.toml".source = '''';
  # };
}
