{
  pkgs,
  arkenfox,
  ...
}: {
  imports = [
    arkenfox.hmModules.default
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    arkenfox = {
      enable = true;
      version = "128.0";
    };
    profiles."0" = {
      id = 0;
      isDefault = true;
      name = "0";
      settings = {
        # prevent extension disabling
        "extensions.autoDisableScopes" = "0";
      };
      arkenfox = {
        enable = true;
        # disable about:config warning
        "0000".enable = true;
        # STARTUP
        "0100".enable = true;
        # QUIETER FOX
        "0300".enable = true;
        # PASSWORDS
        "0900".enable = true;
        # FPP
        "4000".enable = true;
        # disable signon.rememberSignons
        "5000"."5003".enable = true;
      };
      search = {
        default = "DuckDuckGo";
        force = true;
      };
      #extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #  onepassword-password-manager
      #  ublock-origin
      #  sponsorblock
      #  cookie-autodelete
      #  omnivore
      #  web-scrobbler
      #  #tridactyl
      #  #clearurls
      #  ublacklist
      #  (buildFirefoxXpiAddon {
      #    pname = "PwnFox";
      #    version = "1.0.4";
      #    addonId = "PwnFox@bi.tk";
      #    url = "https://addons.mozilla.org/firefox/downloads/file/3996527/pwnfox-1.0.4.xpi";
      #    sha256 = "a4771718dba038132d00c8a4f472eb777a9720af68faf65aa0579ee67cbb64cc";
      #    meta = {};
      #  })
      #  (buildFirefoxXpiAddon {
      #    pname = "Cookie-Editor";
      #    version = "1.13.0";
      #    addonId = "{c3c10168-4186-445c-9c5b-63f12b8e2c87}";
      #    url = "https://addons.mozilla.org/firefox/downloads/file/4241002/cookie_editor-1.13.0.xpi";
      #    sha256 = "3d6fd83a8343dfa5e4461d83c2856264fb74b36b1c165305168d013f4831dbb0";
      #    meta = {};
      #  })
      #];
    };
    # NOTE: we need to use policies to be able to automatically pin and enable extensions
    policies = {
      # extensions
      ExtensionSettings = {
        # 1password
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
        # ublock
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
        # pwnfox
        "PwnFox@bi.tk" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/pwnfox/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
        # cookie-editor
        "{c3c10168-4186-445c-9c5b-63f12b8e2c87}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/cookie-editor/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
        # sponsorblock
        "sponsorBlocker@ajay.app" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
        # omnivore
        "save-extension@omnivore.app" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/omnivore/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
        # web-scrobbler
        "{799c0914-748b-41df-a25c-22d008f9e83f}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/web-scrobbler/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
      };
    };
  };
}
