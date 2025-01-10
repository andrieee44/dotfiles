{ config, pkgs, ... }:
{
  custom.programs.eww.yuck = builtins.readFile (
    pkgs.runCommand "eww.yuck" { }
      ''substitute "${./eww.yuck}" "$out" --replace "jstat" "${config.custom.programs.jstat.package}/bin/jstat"''
  );
}
