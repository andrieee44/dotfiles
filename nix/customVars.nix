{ config, pkgs, lib, options, ... }:
let
	mkFuncOption = name: lib.mkOption {
		type = lib.types.anything;
		description = "Function value for ${name}.";
	};
in
{
	options.customVars = let
		mkStrOption = config.customVars.mkStrOption;
		mkUintOption = config.customVars.mkUintOption;
		mkPkgOption = config.customVars.mkPkgOption;
	in
	{
		mkStrOption = mkFuncOption "mkStrOption";
		mkUintOption = mkFuncOption "mkUintOption";
		mkPkgOption = mkFuncOption "mkPkgOption";
		gui = lib.mkEnableOption "gui";
		shell = mkPkgOption "shell";
		name = mkStrOption "name";
		user = mkStrOption "user";
		email = mkStrOption "email";
		emailFlavor = mkStrOption "emailFlavor";
		emailPassCmd = mkStrOption "emailPassCmd";
		font = mkStrOption "font";
		characterSet = mkStrOption "characterSet";
	};

	config.customVars = {
		mkStrOption = name: lib.mkOption {
			type = lib.types.str;
			description = "String value for ${name}.";
		};

		mkUintOption = name: lib.mkOption {
			type = lib.types.ints.unsigned;
			description = "Unsigned integer value for ${name}.";
		};

		mkPkgOption = name: lib.mkOption {
			type = lib.types.package;
			description = "Package value for ${name}.";
		};

		gui = true;
		shell = pkgs.zsh;
		name = "Andrieee44";
		user = "andrieee44";
		email = "andrieee44@gmail.com";
		emailFlavor = "gmail.com";
		emailPassCmd = "${pkgs.pass}/bin/pass web/gmail.com";
		font = "Sauce Code Pro Nerd Font Mono";
		characterSet = "en_PH.UTF-8";
	};
}
