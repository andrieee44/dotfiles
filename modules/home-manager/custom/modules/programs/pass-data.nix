{ lib, ... }:
{
  options.custom.programs.pass-data.package = lib.mkOption { type = lib.types.package; };
}
