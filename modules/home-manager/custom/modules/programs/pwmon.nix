{ config, lib, ... }:
{
  options.custom.programs.pwmon = {
    enable = lib.mkEnableOption "pwmon";
    package = lib.mkOption { type = lib.types.package; };
  };

  config.home.packages =
    let
      cfg = config.custom.programs.pwmon;
    in
    lib.mkIf cfg.enable [ cfg.package ];
}
