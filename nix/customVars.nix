{ config, pkgs, lib, options, ... }:
let
	mkFuncOption = lib.mkOption {
		type = lib.types.anything;
	};
in {
	options.customVars = let
		mkStrOption = config.customVars.mkStrOption;
	in {
		mkStrOption = mkFuncOption;
		mkUintOption = mkFuncOption;
		mkPkgOption = mkFuncOption;
		mkLinesOption = mkFuncOption;
		sshPassCmd = mkStrOption;
		shShebang = mkStrOption;
		gui = lib.mkEnableOption "";
		font = mkStrOption;
		colorscheme = mkStrOption;
		user = mkStrOption;
		email = mkStrOption;
		emailFlavor = mkStrOption;
		unixUtils = mkStrOption;
		dateFmt = mkStrOption;
		dateGoFmt = mkStrOption;
	};

	config.customVars = {
		mkStrOption = lib.mkOption {
			type = lib.types.str;
		};

		mkUintOption = lib.mkOption {
			type = lib.types.ints.unsigned;
		};

		mkPkgOption = lib.mkOption {
			type = lib.types.package;
		};

		mkLinesOption = lib.mkOption {
			type = lib.types.lines;
		};

		sshPassCmd = let
			sshPassCmd = pkgs.writeScriptBin "sshPassCmd" ''${config.customVars.shShebang}
				${pkgs.pass}/bin/pass "ssh/laptop"
			'';
		in "${sshPassCmd}/bin/sshPassCmd";

		shShebang = ''#!${pkgs.dash}/bin/dash
			set -eu
		'';

		gui = true;
		colorscheme = "nord";
		font = "SauceCodePro";
		user = "andrieee44";
		email = "andrieee44@gmail.com";
		emailFlavor = "gmail.com";
		unixUtils = "${pkgs.toybox}/bin";
		dateFmt = "%b %e %Y (%a) %l:%M %p";
		dateGoFmt = "Jan _2 2006 (Mon) _3:04 PM";
	};
}
