{ pkgs, ... }:
{
  programs.steam = {
    extest.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
}
