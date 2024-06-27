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
					rev = "006154cf37fe972965f7c91b39e591c1c2f7b497";
					hash = "sha256-ESnb0QZAF9QQPDnXMwWqMzJkq/AtiamJ3dn+6hQ4FyY=";
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
