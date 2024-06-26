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
					rev = "d874a6c17470c348eb391d33382600b9546ea423";
					hash = "sha256-PgwJjdaUoZsXGTqXllLVHa90QzXSdusB0MID4JQFYmY=";
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
