{ config, lib, ... }:
{
	options.stylix.targets.nixvim.custom.transparent_bg = {
		lineNumbers = lib.mkEnableOption "background transparency for the NeoVim line numbers";
		otherWindows = lib.mkEnableOption "background transparency for the inactive NeoVim windows";
	};

	config.programs.nixvim.highlight = {
		LineNr = lib.mkIf (config.stylix.targets.nixvim.enable && config.stylix.targets.nixvim.custom.transparent_bg.lineNumbers) {
			bg = "none";
			ctermbg = "none";
		};

		NormalNC = lib.mkIf (config.stylix.targets.nixvim.enable && config.stylix.targets.nixvim.custom.transparent_bg.otherWindows) {
			bg = "none";
			ctermbg = "none";
		};
	};
}
