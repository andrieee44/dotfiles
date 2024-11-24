{ pkgs, ... }:
{
  boot.loader.grub.theme = pkgs.catppuccin-grub;

  stylix.targets = {
    custom.console.enable = true;
    console.enable = false;
    grub.enable = false;
  };
}
