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

	config.programs.mangohud.settings.background_alpha = let
		cfg = config.stylix.targets.custom.mangohud;
	in lib.mkIf cfg.enable (lib.mkForce cfg.background_alpha);
}
