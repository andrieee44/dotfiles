{ config, pkgs, lib, ... }:
{
	custom.programs.cmenu = {
		package = pkgs.buildGoModule {
			name = "cmenu";
			vendorHash = null;

			src = pkgs.fetchFromGitHub {
				owner = "andrieee44";
				repo = "cmenu";
				rev = "9cf508979cdb4d0a55c4ee75fb1e5366afd6ae53";
				hash = "sha256-epXzk7JVSybGPGqzpG3y6/2urblMWC9L+dgaUy6uy7s=";
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
