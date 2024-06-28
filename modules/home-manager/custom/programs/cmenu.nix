{ config, pkgs, lib, ... }:
{
	custom.programs.cmenu = {
		package = pkgs.buildGoModule {
			name = "cmenu";
			vendorHash = null;

			src = pkgs.fetchFromGitHub {
				owner = "andrieee44";
				repo = "cmenu";
				rev = "39535fa5dc6cc88435d7b6d572e37fecba8949d4";
				hash = "sha256-estt7CFQOyrPYHjLhcJs4IbFSYtFIOBBV7L5mXP4rak=";
			};
		};
	};

	xdg.dataFile = lib.mkIf config.custom.programs.cmenu.enable {
		"cmenu/bookmarks.json".text = builtins.toJSON {
			" YouTube " = "https://www.youtube.com/";
			" Messenger | Facebook 󰈌" = "https://www.facebook.com/messages/";
			"󰌌 Monkeytype | A minimalistic, customizable typing test 󰌌" = "https://monkeytype.com/";
			"󱄅 Noogle - Simply find Nix API reference documentation. 󰈙" = "https://noogle.dev/";
			"󱄅 NixOS Search - Packages 󰏔" = "https://search.nixos.org/packages/";
			"󱄅 NixOS Search - Options " = "https://search.nixos.org/options?";
			"󰖌 Hyprland Wiki " = "https://wiki.hyprland.org/";
		};
	};
}
