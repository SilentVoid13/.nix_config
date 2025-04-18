{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common_base.nix
  ];

  networking = {
    hostName = "faye";
  };

  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
    intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
    vpl-gpu-rt # Intel Quick Sync Video
  ];
}
