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
    ubuntu_font_family
  ];

  networking = {
    networkmanager.enable = true;
  };

  programs = {
    zsh.enable = true;
  };

  users.users."${myconf.username}" = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "adbusers"];
    # todo: replace with hash / secret manager
    initialPassword = "test";
    shell = pkgs.zsh;
  };

  system.stateVersion = "23.05";
}
