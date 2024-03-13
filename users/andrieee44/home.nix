{ config, pkgs, ... }:
{
	wayland.windowManager.sway.enable = true;
	nixpkgs.config.allowUnfree = true;
	gtk.enable = true;

	accounts.email.accounts."${config.home.username}" = rec {
		realName = config.home.username;
		address = "andrieee44@gmail.com";
		passwordCommand = "${pkgs.pass}/bin/pass googleAppPasswords/neomutt";
		flavor = "gmail.com";
		primary = true;
		maildir.path = address;
		gpg.key = "B936 149C 88D4 64B3 DC0B 9F0D A555 AF06 F5A8 0AB1";

		signature = {
			delimiter = "-----";
			showSignature = "attach";
			text = "\"The art of programming is the art of organizing complexity.\" -Edsger Dijkstra";
		};
	};

	home = {
		username = "andrieee44";
		homeDirectory = "/home/${config.home.username}";

		packages = with pkgs; [
			ppsspp
			pcsx2
			rpcs3
			dolphin-emu
			wineWowPackages.full
			winetricks
		];

		pointerCursor = {
			package = pkgs.vanilla-dmz;
			name = "Vanilla-DMZ";
		};
	};

	programs = {
		alacritty.enable = true;
		librewolf.enable = true;
		mangohud.enable = true;

		gpg.publicKeys = [
			{
				trust = 5;
				source = ./public.key;
			}
		];
	};

	xdg.configFile.pam-gnupg = {
		enable = config.services.gpg-agent.enable;

		text = ''
			${config.programs.gpg.homedir}
			4761373E4C1DF3223D5D82B64B2B4D7665A3138B
		'';
	};
}
