{ ... }:
{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts = {
        packages = with pkgs; [
          font-awesome
          corefonts
          liberation_ttf
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          # emojis
          noto-fonts-color-emoji
          # Custom fonts
          terminus_font
          nerd-fonts.iosevka
          ubuntu-classic
          inter
          nerd-fonts.dejavu-sans-mono
          source-sans
          ibm-plex
        ];
      };
    };
}
