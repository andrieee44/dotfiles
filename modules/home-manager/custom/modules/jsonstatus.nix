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
					rev = "c4011576157f559c0ed8c37528bfd81daa52568a";
					hash = "sha256-cUny0TBe1ziL9P61JzWQ8bGDt7qxWs7VyI6ucmYr97c=";
				};
			};
		};
	};

	config.xdg.configFile."jsonstatus/jsonstatus.toml".source = let
		cfg = config.custom.programs.jsonstatus;
	in lib.mkIf cfg.enable (toml.generate "jsonstatus.toml" cfg.settings);
}
