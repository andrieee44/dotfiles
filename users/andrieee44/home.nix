{ config, pkgs, ... }:
{
	wayland.windowManager.sway.enable = true;
	gtk.enable = true;

	accounts.email.accounts."${config.home.username}" = {
		realName = config.home.username;
		address = "andrieee44@gmail.com";
		passwordCommand = "${pkgs.pass}/bin/pass googleAppPasswords/neomutt";
		flavor = "gmail.com";
		primary = true;
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

		sessionVariables.SSH_ASKPASS = pkgs.writers.writeDash "ssh_askpass" ''
			set -eu
			${pkgs.pass}/bin/pass "ssh/laptop"
		'';

		packages = with pkgs; [
			dolphin-emu
			pcsx2
			ppsspp
			rpcs3
			#vinegar
			winetricks
			wineWowPackages.full
		];
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
