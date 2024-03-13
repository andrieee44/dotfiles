{ config, pkgs, lib, ... }:
{
	programs.go.goPath = lib.removePrefix config.home.homeDirectory "${config.xdg.dataHome}/go";
	home.packages = lib.mkIf config.programs.go.enable [ pkgs.gotools ];
}
