{ config, lib, ... }:
{
	options.stylix.targets.nixvim.transparent_bg.lineNumbers = lib.mkEnableOption "background transparency for the NeoVim line numbers";

	config.programs.nixvim.highlight.LineNr = lib.mkIf (config.stylix.targets.nixvim.enable && config.stylix.targets.nixvim.transparent_bg.lineNumbers) {
		bg = "none";
		ctermbg = "none";
	};
}
