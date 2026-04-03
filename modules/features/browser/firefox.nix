{ inputs, ... }:
{
  flake.modules.homeManager.firefox =
    { pkgs, ... }:
    {
      imports = [
        inputs.arkenfox.hmModules.arkenfox
      ];

      programs.firefox = {
        enable = true;
        arkenfox = {
          enable = true;
          version = "128.0";
        };
        profiles = {
          "0" = {
            isDefault = true;
            arkenfox = {
              enable = true;
              "0000".enable = true;
              "0100".enable = true;
              "0300".enable = true;
              "0900".enable = true;
              "4000".enable = true;
              "5000".enable = true;
            };
            settings = {
              "browser.compactmode.show" = true;
              "sidebar.verticalTabs" = true;
              "sidebar.revamp" = true;
              "gfx.webrender.all" = true;
              "media.ffmpeg.vaapi.enabled" = true;
              "gfx.canvas.accelerated" = true;
              "browser.search.defaultenginename" = "DuckDuckGo";
              "browser.search.order.1" = "DuckDuckGo";
              "privacy.donottrackheader.enabled" = true;
            };
          };
        };
        policies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          DisablePocket = true;
          DisableFirefoxAccounts = true;
          DisableAccounts = true;
          DontCheckDefaultBrowser = true;
          ExtensionSettings = {
            "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
              installation_mode = "force_installed";
            };
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            "{0f2b5314-b8a2-4a7f-80a3-28ed8c4e72f4}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/pwnfox/latest.xpi";
              installation_mode = "force_installed";
            };
            "{b812bf1d-e79d-4a73-8d3e-3ad5c353c9db}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/cookie-editor/latest.xpi";
              installation_mode = "force_installed";
            };
            "sponsorBlocker@ajay.app" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
              installation_mode = "force_installed";
            };
            "{799c0914-748b-41df-a25c-22d008f9e83f}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/web-scrobbler/latest.xpi";
              installation_mode = "force_installed";
            };
            "{84601290-bec9-494a-b11c-1571c482571c}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ctrl-number-to-switch-tabs/latest.xpi";
              installation_mode = "force_installed";
            };
            "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
              installation_mode = "force_installed";
            };
            "magnolia@12.34" = {
              install_url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };
    };
}
