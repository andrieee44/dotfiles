{ config, ... }:
{
	config.programs.go = {
		goPath = "${config.xdg.dataHome}/go";
	};
}
