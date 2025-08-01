{
  myconf,
  pkgs,
  ...
}:
{
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Paris";

  fonts = {
    packages = with pkgs; [
      font-awesome
      corefonts
      liberation_ttf
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      # emojis
      noto-fonts-emoji
      noto-fonts-color-emoji
      # Custom fonts
      terminus_font
      #iosevka
      nerd-fonts.iosevka
      ubuntu_font_family
    ];
  };

  networking = {
    networkmanager.enable = true;
  };

  programs = {
    zsh.enable = true;
  };

  users.users."${myconf.username}" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "adbusers"
      "wireshark"
    ];
    # todo: replace with hash / secret manager
    initialPassword = "test";
    shell = pkgs.zsh;
  };

  system.stateVersion = "23.05";
}
