{
  inputs,
  config,
  pkgs,
  specialArgs,
  ...
}: let
  nur = import specialArgs.nur {
    inherit pkgs;
    nurpkgs = pkgs;
  };
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      "0" = {
        id = 0;
        isDefault = true;
        name = "0";
        extensions = with nur.repos.rycee.firefox-addons; [
          onepassword-password-manager
          ublock-origin
          sponsorblock
          cookie-autodelete
          tridactyl
          clearurls
          ublacklist
          (buildFirefoxXpiAddon {
            pname = "PwnFox";
            version = "1.0.4";
            addonId = "PwnFox@bi.tk";
            url = "https://addons.mozilla.org/firefox/downloads/file/3996527/pwnfox-1.0.4.xpi";
            sha256 = "a4771718dba038132d00c8a4f472eb777a9720af68faf65aa0579ee67cbb64cc";
            meta = {};
          })
        ];
      };
    };
  };
}
