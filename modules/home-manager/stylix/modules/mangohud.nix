{ config, lib, ... }:
{
	options.stylix.targets.custom.mangohud = {
		enable = lib.mkEnableOption "custom implementation of styling mangohud";

		background_alpha = lib.mkOption {
			description = "background transparency for mangohud";
			type = lib.types.float;
			default = 0.5;
		};
	};

	config.programs.mangohud.settings = let
		cfg = config.stylix.targets.custom.mangohud;
	in {
		background_alpha = lib.mkIf cfg.enable (lib.mkForce cfg.background_alpha);
		font_file_text = config.stylix.fonts.monospace.name;
	};
}
