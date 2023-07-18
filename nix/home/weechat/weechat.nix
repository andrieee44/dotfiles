{ config, options, lib, pkgs, ... }:
let
	cfg = config.programs.weechat;
in
{
	options.programs.weechat = {
		enable = lib.mkEnableOption "weechat - the extensible chat client";

		plugins = lib.mkOption {
			type = lib.types.listOf lib.types.package;
			default = [];
			description = "List of weechat plugins.";
		};
	};

	config = lib.mkIf cfg.enable {
		nixpkgs.overlays = [
			(final: prev:
			{
				weechat = prev.weechat.override {
					configure = { availablePlugins, ... }:
					{
						scripts = cfg.plugins;
					};
				};
			})
		];

		home.packages = [
			pkgs.weechat
		];

		programs.weechat = {
			plugins = with pkgs.weechatScripts; [
				weechat-grep
			];
		};
	};
}
