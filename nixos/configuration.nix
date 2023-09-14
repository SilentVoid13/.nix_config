{
  inputs,
  myconf,
  system,
  pkgs,
  ...
}: let
in {
  nixpkgs.config.allowUnfree = true;
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Paris";

  fonts.packages = with pkgs; [
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

  users.users."${myconf.username}" = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    # todo: replace with secret manager
    initialPassword = "test";
  };

  system.stateVersion = "23.05";
}
