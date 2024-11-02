{ config, lib, ... }:
{
  programs.go.goPath = lib.removePrefix config.home.homeDirectory "${config.xdg.dataHome}/go";
}
