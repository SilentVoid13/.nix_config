{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  networking = {
    hostName = "faye";
  };

  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
    # intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
    intel-compute-runtime
    vpl-gpu-rt # Intel Quick Sync Video
  ];

  services.fwupd.enable = true;
  services.throttled.enable = true;
  # unsupported for this CPU apparently
  # services.thermald.enable = true;

  environment.systemPackages = with pkgs; [
    nvtopPackages.intel
    kdiskmark
  ];

  ## auto-gen

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  # networking.interfaces.wwan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
