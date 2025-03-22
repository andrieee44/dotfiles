{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.oversteer ];
}
