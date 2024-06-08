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
				vendorHash = "sha256-GzK4Jj65P0zNLmFjLM0jTE/Ls5VD6Tim3kzMKTE+wuE=";

				src = pkgs.fetchFromGitHub {
					owner = "andrieee44";
					repo = "jsonstatus";
					rev = "2ce684d4b1a8f5e0826cac5626fc5cc44714010c";
					hash = "sha256-fnrS07PNJ4De551DrillpNsfCJ6X17ZjqxBKJnMfLfE=";
				};
			};
		};
	};

	config.xdg.configFile."jsonstatus/jsonstatus.toml".source = let
		cfg = config.custom.programs.jsonstatus;
	in lib.mkIf cfg.enable (toml.generate "jsonstatus.toml" cfg.settings);
}
