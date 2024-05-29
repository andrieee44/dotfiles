{ config, lib, ... }:
{
	options.stylix.targets.fzf.custom.enable = lib.mkEnableOption "custom implementation of stylix.targets.fzf";

	config.programs.fzf.colors = lib.mkIf config.stylix.targets.fzf.custom.enable {
		fg = "white";
		hl = "blue";
		"fg+" = "bright-white";
		"bg+" = "black";
		info = "yellow";
		border = "blue";
		prompt = "yellow";
		pointer = "cyan";
		marker = "cyan";
		spinner = "cyan";
		header = "blue";
	};
}
