{config, ...}: let
  # TODO: improve that
  home = config.home.homeDirectory;
  sockPath = "${home}/.1password/agent.sock";
in {
  # https://github.com/NixOS/nixpkgs/issues/222991
  # https://github.com/NixOS/nixpkgs/issues/240810
  # Cannot configure PAM without NixOS module
  #home.packages = with pkgs; [
  #  _1password-gui
  #];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent "${sockPath}"
    '';
    matchBlocks = {
      "services.lab" = {
        user = "git";
        port = 2222;
      };
    };
  };
}
