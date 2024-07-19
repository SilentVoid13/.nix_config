{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common_base.nix
  ];

  # LUKS partition
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/c883467b-222e-4a61-97ee-6d71cd682f34";
      preLVM = true;
    };
  };

  networking = {
    hostName = "faye";
  };

  zramSwap.enable = true;

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];
}
