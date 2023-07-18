{ config, options, lib, pkgs, ... }:
let
	cfg = config.programs.weechat;
in
{
	options.programs.weechat = {
		enable = lib.mkEnableOption "weechat - the extensible chat client";
		package = lib.mkPackageOptionMD pkgs "weechat" {};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			cfg.package
		];

		programs.weechat = {
			package = pkgs.weechat;
		};
	};
}
