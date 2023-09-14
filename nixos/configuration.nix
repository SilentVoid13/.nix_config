{
  inputs,
  system,
  pkgs,
  ...
}: let
in {
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Paris";

  fonts.fonts = with pkgs; [
    font-awesome
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    # Custom fonts
    terminus_font
    iosevka
  ];

  networking = {
    networkmanager.enable = true;
  };

  users.users.silent = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    # todo: replace with secret manager
    initialPassword = "test";
  };

  system.stateVersion = "23.05";
}
