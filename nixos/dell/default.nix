{
  inputs,
  system,
  pkgs,
  ...
}: let
in {
  networking = {
    hostName = "jet";
    wireless.enable = true;
    useDHCP = true;
  };

  security = {
    polkit.enable = true;
  };

  programs = {
    _1password-gui = {
      enable = true;
      # Certain features, including CLI integration and system authentication support,
      # require enabling PolKit integration on some desktop environments (e.g. Plasma).
      polkitPolicyOwners = ["yourUsernameHere"];
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
