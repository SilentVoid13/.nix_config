{ inputs, ... }:
{
  flake.modules.homeManager.brave =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        brave
      ];
    };

  flake.modules.homeManager.helium =
    { pkgs, ... }:
    let
      initialPrefs = pkgs.writeText "initial_preferences" (
        builtins.toJSON {
          helium.browser = {
            layout = 2;
            show_avatar_button = false;
            zen_mode = true;
            zen_mode_sidebar_pinned = true;
          };
          vertical_tabs = {
            collapsed_state = false;
            uncollapsed_width = 200;
          };
        }
      );

      helium = inputs.helium.packages.${pkgs.system}.default.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          install -Dm644 ${initialPrefs} $out/opt/helium/initial_preferences
        '';
      });
    in
    {
      home.packages = [
        helium
      ];
    };

  # NOTE: chromium can be properly configured only as nixos
  flake.modules.nixos.chromium =
    { ... }:
    {
      programs.chromium = {
        enable = true;

        extraOpts = {
          # disable telemetry
          MetricsReportingEnabled = false;

          # disable feedback
          FeedbackSurveysEnabled = false;
          UserFeedbackAllowed = false;

          # disable the password manager
          PasswordManagerEnabled = false;

          # disable autofill
          AutofillCreditCardEnabled = false;
          AutofillAddressEnabled = false;

          # show full urls
          ShowFullUrlsInAddressBar = true;

          # disable promotions
          PromotionsEnabled = false;

          # Restore previous session on startup.
          RestoreOnStartup = 1;
        };

        extensions = [
          # "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin lite
          "gejiddohjgogedgjnonbofjigllpkmbf" # 1password nightly
          "hlkenndednhfkekhgcdicdfddnkalmdm" # cookie editor
          "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
          "lebiggkccaodkkmjeimmbogdedcpnmfb" # block-site
        ];

        initialPrefs = {
          helium = {
            browser = {
              layout = 2; # vertical tabs
            };
          };
          vertical_tabs = {
            collapsed_state = false;
            uncollapsed_width = 250;
          };
        };
      };
    };

  flake.modules.nixos.brave = { ... }: {
    programs.chromium = {
      enable = true;
      extraOpts = {
        BraveRewardsDisabled = true;
        BraveWalletDisabled = true;
        BraveVPNDisabled = true;
        BraveAIChatEnabled = false;
        BraveNewsDisabled = true;
        BraveTalkDisabled = true;
      };
      initialPrefs = {
        brave.tabs = {
          vertical_tabs_enabled = true;
          vertical_tabs_on_right = false;
        };
      };
    };
  };
}
