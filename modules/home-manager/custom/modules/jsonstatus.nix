{ config, pkgs, lib, ... }:
let
	toml = (pkgs.formats.toml {});
in {
	options.custom.programs.jsonstatus = {
		enable = lib.mkEnableOption "jsonstatus";
		settings = lib.mkOption { type = lib.types.attrsOf toml.type; };

		package = lib.mkOption {
			type = lib.types.package;
			default = pkgs.buildGoModule {
				name = "jsonstatus";
				vendorHash = "sha256-7jlGdnOoeVVG7qp5InYnTrwxDHvOVJapiybGgopIjYE=";

				src = pkgs.fetchFromGitHub {
					owner = "andrieee44";
					repo = "jsonstatus";
					rev = "bf489b5c317f12e7e9e1406935a6122cbd43dab7";
					hash = "sha256-pzmUm1Toh6CrkAKugHYD0uDohOPLBLJqxdlPy/jEPIw=";
				};
			};
		};
	};

	config = let
		cfg = config.custom.programs.jsonstatus;
	in {
		home.packages = [ cfg.package ];
		xdg.configFile."jsonstatus/jsonstatus.toml".source = lib.mkIf cfg.enable (toml.generate "jsonstatus.toml" cfg.settings);
	};
}
