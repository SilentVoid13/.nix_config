{ self, ... }:
{
  flake.modules.nixos.base-system =
    { pkgs, ... }:
    {
      i18n.defaultLocale = "en_US.UTF-8";
      time.timeZone = "Europe/Paris";

      networking = {
        networkmanager.enable = true;
        networkmanager.wifi.powersave = false;
      };

      programs.zsh.enable = true;

      users.users."${self.myconf.username}" = {
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

      environment.systemPackages = with pkgs; [
        vim
        git
        just
        sbctl
        yubioath-flutter
        docker-compose
        vial
        android-tools
        # required for xdg-desktop-portal-gnome
        nautilus
      ];

      imports = [
        (if builtins.pathExists ../extra/nixos.nix then import ../extra/nixos.nix else { })
      ];
    };
}
