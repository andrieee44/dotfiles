{ config, lib, ... }:
{
  options.stylix.targets.custom.hyprlock.enable =
    lib.mkEnableOption "custom implementation of styling hyprlock";

  config.programs.hyprlock.settings = lib.mkIf config.stylix.targets.custom.hyprlock.enable {
    background = lib.mkForce [ { path = builtins.toString config.stylix.image; } ];
  };
}
