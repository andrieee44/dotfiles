{ lib, ... }:
{
  options.custom.programs.pass-data = {
    enable = lib.mkEnableOption "pass-data";
    package = lib.mkOption { type = lib.types.package; };
  };
}
