{ lib, ... }:
{
	options.stylix = {
		enable = lib.mkEnable "whether to enable stylix with dummy options for nix-on-droid";
		polarity = { type = lib.types.enum [ "either" "light" "dark" ]; };

		base16Scheme = {
			type = with lib.types;
				oneOf [ path lines attrs ];
		};

		wallpaper = lib.mkOption {
			type = with lib.types;
				coercedTo package toString path;
		};

		cursor = {
			name = { type = lib.types.str; };
			package = { type = lib.types.package; };
			size = { type = lib.types.int; };
		};

		fonts = let
			fontType = lib.types.submodule {
				options = {
					package = lib.mkOption { type = lib.types.package; };
					name = lib.mkOption { type = lib.types.str; };
				};
			};
		in {
			serif = lib.mkOption { types = fontType; };
			sansSerif = lib.mkOption { types = fontType; };
			monospace = lib.mkOption { types = fontType; };
			emoji = lib.mkOption { types = fontType; };

			sizes = {
				applications = lib.mkOption { types = lib.types.ints.unsigned; };
				desktop = lib.mkOption { types = lib.types.ints.unsigned; };
				popups = lib.mkOption { types = lib.types.ints.unsigned; };
				terminal = lib.mkOption { types = lib.types.ints.unsigned; };
			};
		};

		opacity = {
			applications = { type = lib.types.float; };
			desktop = { type = lib.types.float; };
			popups 	= { type = lib.types.float; };
			terminal = { type = lib.types.float; };
		};
	};
}
