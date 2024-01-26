{ config, pkgs, lib, options, ... }:
let
	mkFuncOption = lib.mkOption {
		type = lib.types.anything;
	};
in {
	options.customVars = let
		mkStrOption = config.customVars.mkStrOption;
		attrs = lib.mkOption {
			type = lib.types.attrs;
		};
	in {
		mkFuncOption = mkFuncOption;
		mkStrOption = mkFuncOption;
		mkUintOption = mkFuncOption;
		mkPkgOption = mkFuncOption;
		mkLinesOption = mkFuncOption;
		sshPassCmd = mkStrOption;
		shShebang = mkStrOption;
		gui = lib.mkEnableOption "";
		font = mkStrOption;
		consoleFont = mkStrOption;
		user = mkStrOption;
		email = mkStrOption;
		emailFlavor = mkStrOption;
		unixUtils = mkStrOption;
		dateFmt = mkStrOption;
		dateGoFmt = mkStrOption;
		colorscheme = mkStrOption;
		colorNums = attrs;
		colorschemes = attrs;
	};

	config.customVars = {
		mkFuncOption = mkFuncOption;
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
		font = "saucecodepro";
		consoleFont = "${pkgs.terminus_font}/share/consolefonts/ter-122b.psf.gz";
		user = "andrieee44";
		email = "andrieee44@gmail.com";
		emailFlavor = "gmail.com";
		unixUtils = "${pkgs.toybox}/bin";
		dateFmt = "%b %e %Y (%a) %l:%M %p";
		dateGoFmt = "Jan _2 2006 (Mon) _3:04 PM";
		colorscheme = "nord";
		colorNums = {
			normal = {
				black = "0";
				red = "1";
				green = "2";
				yellow = "3";
				blue = "4";
				magenta = "5";
				cyan = "6";
				white = "7";
			};

			bright = {
				black = "8";
				red = "9";
				green = "10";
				yellow = "11";
				blue = "12";
				magenta = "13";
				cyan = "14";
				white = "15";
			};
		};

		colorschemes = {
			default = {
				normal = {
					black = "#000000";
					red = "#aa0000";
					green = "#00aa00";
					yellow = "#aa5500";
					blue = "#0000aa";
					magenta = "#aa00aa";
					cyan = "#00aaaa";
					white = "#aaaaaa";
				};

				bright = {
					black = "#555555";
					red = "#ff5555";
					green = "#55ff55";
					yellow = "#ffff55";
					blue = "#5555ff";
					magenta = "#ff55ff";
					cyan = "#55ffff";
					white = "#ffffff";
				};
			};

			nord = {
				normal = {
					black = "#3b4252";
					red = "#bf616a";
					green = "#a3be8c";
					yellow = "#ebcb8b";
					blue = "#81a1c1";
					magenta = "#b48ead";
					cyan = "#88c0d0";
					white = "#e5e9f0";
				};

				bright = {
					black = "#4c566a";
					red = "#bf616a";
					green = "#a3be8c";
					yellow = "#ebcb8b";
					blue = "#81a1c1";
					magenta = "#b48ead";
					cyan = "#8fbcbb";
					white = "#eceff4";
				};
			};
		};
	};
}
