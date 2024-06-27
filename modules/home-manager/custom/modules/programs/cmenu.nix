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
					rev = "15958b4fc703ede1166d051f5fa5c800de43e2a7";
					hash = "sha256-RXB69O6GRxFwkHzi+iOvpHQolK5vg3SPI0uX/GomMZU=";
				};
			};
		};
	};

	config.home.packages = let
		cfg = config.custom.programs.cmenu;
	in [ cfg.package ];
}