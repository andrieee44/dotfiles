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
					rev = "94149f39cdb99d69be3137f0cf0a68565d9a36cf";
					hash = "sha256-wHRZGkJf0MzLYOlXanXuMDrgqxEfYDksj7ravPXLTr0=";
				};
			};
		};
	};

	config.home.packages = let
		cfg = config.custom.programs.cmenu;
	in [ cfg.package ];
}
