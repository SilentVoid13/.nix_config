{ ... }:
{
  flake.modules.nixos.bluetooth =
    { ... }:
    {
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;
    };
}
