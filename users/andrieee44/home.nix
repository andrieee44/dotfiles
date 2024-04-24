{ config, pkgs, ... }:
{
	accounts.email.accounts."andrieee44@gmail.com" = {
		realName = "andrieee44";
		address = "andrieee44@gmail.com";
		passwordCommand = "${pkgs.pass}/bin/pass googleAppPasswords/neomutt";
		flavor = "gmail.com";
		primary = true;
		notmuch.enable = config.programs.notmuch.enable;
		maildir.path = config.accounts.email.accounts."${config.home.username}".address;

		gpg = {
			key = "B936 149C 88D4 64B3 DC0B 9F0D A555 AF06 F5A8 0AB1";
			signByDefault = true;
		};

		mbsync = {
			enable = config.programs.mbsync.enable;
			create = "both";
		};

		neomutt = {
			enable = config.programs.neomutt.enable;
		};

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
	};

	programs.gpg.publicKeys = [
		{
			trust = 5;
			source = ./public.key;
		}
	];

	xdg.configFile.pam-gnupg = {
		enable = config.services.gpg-agent.enable;

		text = ''
			${config.programs.gpg.homedir}
			4761373E4C1DF3223D5D82B64B2B4D7665A3138B
		'';
	};
}
