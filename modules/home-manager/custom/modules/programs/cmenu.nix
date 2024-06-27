{ config, pkgs, lib, ... }:
{
	options.custom.programs.cmenu = {
		enable = lib.mkEnableOption "cmenu";

		package = lib.mkOption {
			type = lib.types.package;
			default = pkgs.buildGoModule {
				name = "cmenu";
				vendorHash = null;

				src = pkgs.fetchFromGitHub {
					owner = "andrieee44";
					repo = "cmenu";
					rev = "39535fa5dc6cc88435d7b6d572e37fecba8949d4";
					hash = "sha256-estt7CFQOyrPYHjLhcJs4IbFSYtFIOBBV7L5mXP4rak=";
				};
			};
		};
	};

	config.home.packages = let
		cfg = config.custom.programs.cmenu;
	in [ cfg.package ];
}
