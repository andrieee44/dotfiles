{ config, pkgs, lib, ... }:
{
	custom.programs.cmenu = {
		package = pkgs.buildGoModule {
			name = "cmenu";
			vendorHash = null;

			src = pkgs.fetchFromGitHub {
				owner = "andrieee44";
				repo = "cmenu";
				rev = "72a0fe0bc183ad4c1ca563d0be1267ad9eb6c197";
				hash = "sha256-4+/oIlnvD/TnXYIRCVLtm/Wdhbidsx0Z60XEioSP43Q=";
			};
		};
	};

	xdg.dataFile = lib.mkIf config.custom.programs.cmenu.enable {
		"cmenu/bookmarks.json".text = builtins.toJSON {
			" YouTube " = "https://www.youtube.com/";
			" Messenger | Facebook 󰈌" = "https://www.facebook.com/messages/";
			"󰌌 Monkeytype | A minimalistic, customizable typing test 󰌌" = "https://monkeytype.com/";
			"󱄅 Noogle - Simply find Nix API reference documentation. 󰈙" = "https://noogle.dev/";
			"󱄅 NixOS Search - Packages 󰏔" = "https://search.nixos.org/packages?";
			"󱄅 NixOS Search - Options " = "https://search.nixos.org/options?";
			"󰖌 Hyprland Wiki " = "https://wiki.hyprland.org/";
			"󰊤 GitHub 󰊤" = "https://github.com/";
		};
	};
}
