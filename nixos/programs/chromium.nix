{ pkgs, ... }:
{
  # NOTE: chromium can be properly configured only as root
  programs.chromium = {
    enable = true;

    extraOpts = {
      # brave opts
      BraveRewardsDisabled = true;
      BraveWalletDisabled = true;
      BraveVPNDisabled = true;
      BraveAIChatEnabled = false;
      BraveNewsDisabled = true;
      BraveTalkDisabled = true;

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
    };

    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin lite
      "gejiddohjgogedgjnonbofjigllpkmbf" # 1password nightly
      "hlkenndednhfkekhgcdicdfddnkalmdm" # cookie editor
      "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
    ];

    initialPrefs = {
      brave.tabs = {
        vertical_tabs_enabled = true;
        vertical_tabs_on_right = false;
        # vertical_tabs_collapsed = true;
      };
    };
  };
}
