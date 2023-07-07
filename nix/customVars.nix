{ config, pkgs, lib, options, ... }:
let
	mkFuncOption = name: lib.mkOption {
		type = lib.types.anything;
		description = "Function value for ${name}.";
	};
in {
	options.customVars = let
		mkStrOption = config.customVars.mkStrOption;
		mkUintOption = config.customVars.mkUintOption;
		mkPkgOption = config.customVars.mkPkgOption;
		mkLinesOption = config.customVars.mkLinesOption;
	in {
		mkStrOption = mkFuncOption "mkStrOption";
		mkUintOption = mkFuncOption "mkUintOption";
		mkPkgOption = mkFuncOption "mkPkgOption";
		mkLinesOption = mkFuncOption "mkLinesOption";
		sshPassCmd = mkStrOption "sshPassCmd";
		shShebang = mkStrOption "shShebang";
		gui = lib.mkEnableOption "gui";
		colorscheme = mkStrOption "colorscheme";
		user = mkStrOption "user";
		email = mkStrOption "email";
		emailFlavor = mkStrOption "emailFlavor";
		unixUtils = mkStrOption "unixUtils";
		dateFmt = mkStrOption "dateFmt";
		dateGoFmt = mkStrOption "dateGoFmt";
	};

	config.customVars = let
		pass = file: "${pkgs.pass}/bin/pass ${file}";
	in {
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

		mkLinesOption = name: lib.mkOption {
			type = lib.types.lines;
			description = "Strings concatenated with '\n' value for ${name}.";
		};

		sshPassCmd = let
			sshPassCmd = pkgs.writeScriptBin "sshPassCmd" ''#!${pkgs.dash}/bin/dash
				set -eu
				${pass "ssh/laptop"}
			'';
		in "${sshPassCmd}/bin/sshPassCmd";

		shShebang = ''#!${pkgs.dash}/bin/dash
			set -eu
		'';

		gui = true;
		colorscheme = "nord";
		user = "andrieee44";
		email = "andrieee44@gmail.com";
		emailFlavor = "gmail.com";
		unixUtils = "${pkgs.toybox}/bin";
		dateFmt = "%b %e %Y (%a) %l:%M %p";
		dateGoFmt = "Jan _2 2006 (Mon) _3:04 PM";
	};
}
