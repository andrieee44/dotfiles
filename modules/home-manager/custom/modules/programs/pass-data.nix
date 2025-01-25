{ config, lib, ... }:
{
  options.custom.programs.pass-data = {
    enable = lib.mkEnableOption "pass-data";
    package = lib.mkOption { type = lib.types.package; };
  };

  config.home.packages =
    let
      cfg = config.custom.programs.pass-data;
    in
    lib.mkIf cfg.enable [ cfg.package ];
}
