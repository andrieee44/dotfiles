{ config, lib, ... }:
{
  options.custom.programs.lsbin = {
    enable = lib.mkEnableOption "lsbin";
    package = lib.mkOption { type = lib.types.package; };
  };

  config.home.packages =
    let
      cfg = config.custom.programs.lsbin;
    in
    lib.mkIf cfg.enable [ cfg.package ];
}
