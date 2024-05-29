{ config, lib, ... }:
{
	options.stylix.targets.mangohud.custom.background_alpha = lib.mkOption {
		description = "custom implementation of background transparency for MangoHud";
		type = lib.types.float;
		default = 0.5;
	};

	config.programs.mangohud.settings.background_alpha = let
		cfg = config.stylix.targets.mangohud;
	in lib.mkIf cfg.enable (lib.mkForce cfg.custom.background_alpha);
}
