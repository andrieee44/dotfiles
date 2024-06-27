{ config, pkgs, ... }:
{
	custom.programs.eww.yuck = builtins.readFile (pkgs.runCommand "eww.yuck" {} ''
		substitute "${./eww.yuck}" "$out" --replace-fail "jsonstatus" "${config.custom.programs.jsonstatus.package}/bin/jsonstatus"
	'');
}
