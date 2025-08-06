{ inputs, ... }:
{
  imports = [
    inputs.sherlock.homeManagerModules.default
  ];

  programs.sherlock = {
    enable = true;
    settings = {
      aliases = {
        vesktop = {
          name = "Discord";
        };
      };
      config = {
        debug = {
          try_suppress_warnings = true;
        };
      };
      launchers = [
        {
          name = "App Launcher";
          type = "app_launcher";
          args = { };
          priority = 1;
          home = true;
        }
        {
          name = "Calculator";
          type = "calculation";
          args = {
            capabilities = [
              "calc.math"
              "calc.units"
            ];
          };
          priority = 1;
        }
        {
          name = "Emoji";
          type = "emoji_picker";
          args = {
            default_skin_tone = "Simpsons";
          };
          priority = 4;
          home = "Search";
        }
        {
          name = "Nix package";
          type = "web_launcher";
          alias = "nix";
          args = {
            # https://search.nixos.org/packages?query=test
            search_engine = "google";
            icon = "google";
          };
          priority = 1;
        }
        {
          name = "Command";
          type = "command";
          alias = "ex";
          args = {
            commands = {
              "vpn2" = {
                exec = "nmcli c u vpn2";
              };
            };
          };
          priority = 1;
        }
      ];
      # style = null;
    };
  };
}
