{ config, lib, ... }:
{
	options.customVars.fonts = {
		nerdFont = config.customVars.mkOption lib.types.bool;
		nerdFontLuaVar = config.customVars.mkOption lib.types.str;
	};

	config = {
		customVars.fonts.nerdFontLuaVar = ''
			os.getenv('XDG_SESSION_TYPE') ~= 'tty' and ${if config.customVars.fonts.nerdFont then
				"true" else "false"
			}
		'';

		xdg.configFile.lficons = {
			enable = config.programs.lf.enable;
			target = "lf/icons";
			source = ./lficons;
		};
	};
}
