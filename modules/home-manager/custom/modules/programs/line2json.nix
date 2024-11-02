{ config, lib, ... }:
{
  options.custom.programs.line2json = {
    enable = lib.mkEnableOption "line2json";
    package = lib.mkOption { type = lib.types.package; };
  };

  config.home.packages =
    let
      cfg = config.custom.programs.line2json;
    in
    lib.mkIf cfg.enable [ cfg.package ];
}
