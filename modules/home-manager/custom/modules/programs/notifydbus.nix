{ config, lib, ... }:
{
  options.custom.programs.notifydbus = {
    enable = lib.mkEnableOption "notifydbus";
    package = lib.mkOption { type = lib.types.package; };
  };

  config.home.packages =
    let
      cfg = config.custom.programs.notifydbus;
    in
    lib.mkIf cfg.enable [ cfg.package ];
}
