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
					rev = "1350e3e3d9c092362f9fc12202003d25ed3dc09e";
					hash = "sha256-o0jgVhaLDvW0jjhlUeEWnHSF+hxckvQMD0gYcGI1rX4=";
				};
			};
		};
	};

	config.xdg.configFile."jsonstatus/jsonstatus.toml".source = let
		cfg = config.custom.programs.jsonstatus;
	in lib.mkIf cfg.enable (toml.generate "jsonstatus.toml" cfg.settings);
}
