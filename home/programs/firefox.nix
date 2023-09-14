{
  inputs,
  config,
  pkgs,
  specialArgs,
  ...
}: let
    nurpkgs = specialArgs.nurpkgs;
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      "0" = {
        id = 0;
        isDefault = true;
        name = "0";
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          onepassword-password-manager
          ublock-origin
          sponsorblock
          cookie-autodelete
          tridactyl
          #clearurls
          ublacklist
          (buildFirefoxXpiAddon {
            pname = "PwnFox";
            version = "1.0.4";
            addonId = "PwnFox@bi.tk";
            url = "https://addons.mozilla.org/firefox/downloads/file/3996527/pwnfox-1.0.4.xpi";
            sha256 = "a4771718dba038132d00c8a4f472eb777a9720af68faf65aa0579ee67cbb64cc";
            meta = {};
          })
          (buildFirefoxXpiAddon {
            pname = "Cookie-Editor";
            version = "1.11.0";
            addonId = "{c3c10168-4186-445c-9c5b-63f12b8e2c87}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4081799/cookie_editor-1.11.0.xpi";
            sha256 = "584ae99825b959a32c600b232f639b2a8fd09ddd501dac7a0f56ecb6d79996ee";
            meta = {};
          })
        ];
      };
    };
  };
}
