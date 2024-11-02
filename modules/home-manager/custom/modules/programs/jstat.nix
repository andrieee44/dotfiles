{ config, lib, ... }:
{
  options.custom.programs.jstat = {
    enable = lib.mkEnableOption "jstat";
    package = lib.mkOption { type = lib.types.package; };
  };

  config.home.packages =
    let
      cfg = config.custom.programs.jstat;
    in
    lib.mkIf cfg.enable [ cfg.package ];
}
