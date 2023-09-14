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

  boot = {
    loader = {
      sytemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
