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

  fonts = {
    packages = with pkgs; [
      font-awesome
      corefonts
      liberation_ttf
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      # emojis
      noto-fonts-emoji
      noto-fonts-color-emoji
      # Custom fonts
      terminus_font
      #iosevka
      (nerdfonts.override {fonts = ["Iosevka"];})
      ubuntu_font_family
    ];

    #enableDefaultFonts = true;
    #fontDir.enable = true;
    #fontconfig = {
    #defaultFonts = {
    #emoji = [ "Noto Color Emoji" ];
    #};
    #  # from https://christitus.com/emoji/
    #  localConf = ''
    #    <match target="pattern">
    #      <test qual="any" name="family"><string>Segoe UI Emoji</string></test>
    #      <edit name="family" mode="assign" binding="same"><string>Noto Color Emoji</string></edit>
    #    </match>
    #  '';
    #};
  };

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
