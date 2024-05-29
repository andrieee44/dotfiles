{ config, lib, ... }:
{
	options.stylix.targets.nixvim.custom.transparent_bg = {
		lineNumbers = lib.mkEnableOption "custom implementation of background transparency for the NeoVim line numbers";
		otherWindows = lib.mkEnableOption "custom implementation of background transparency for the inactive NeoVim windows";
	};

	config.programs.nixvim.highlight = let
		cfg = config.stylix.targets.nixvim;
	in {
		LineNr = lib.mkIf (cfg.enable && cfg.custom.transparent_bg.lineNumbers) {
			bg = "none";
			ctermbg = "none";
		};

		NormalNC = lib.mkIf (cfg.enable && cfg.custom.transparent_bg.otherWindows) {
			bg = "none";
			ctermbg = "none";
		};
	};
}
