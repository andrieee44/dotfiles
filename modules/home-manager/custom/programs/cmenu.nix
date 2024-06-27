{ config, pkgs, lib, ... }:
{
	custom.programs.cmenu = {
		package = pkgs.buildGoModule {
			name = "cmenu";
			vendorHash = null;

			src = pkgs.fetchFromGitHub {
				owner = "andrieee44";
				repo = "cmenu";
				rev = "15958b4fc703ede1166d051f5fa5c800de43e2a7";
				hash = "sha256-RXB69O6GRxFwkHzi+iOvpHQolK5vg3SPI0uX/GomMZU=";
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
		};
	};
}
