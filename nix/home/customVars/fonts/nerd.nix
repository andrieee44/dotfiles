{ config, lib, options, ... }:
{
	options.customVars.fonts = let
		mkFuncOption = lib.mkOption {
			type = lib.types.anything;
		};
	in {
		nerdFontBool = lib.mkEnableOption "";
		nerdFontStr = mkFuncOption;
		nerdFontMk = mkFuncOption;
	};

	config.customVars.fonts = let
		nerdFontBool = config.customVars.fonts.nerdFontBool;
	in {
		nerdFontStr = lib.optionalString nerdFontBool;
		nerdFontMk = lib.mkIf nerdFontBool;
	};
}
