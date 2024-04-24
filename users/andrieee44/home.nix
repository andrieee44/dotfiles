{ config, pkgs, ... }:
{
	accounts.email = {
		maildirBasePath = "${config.xdg.dataHome}/maildir";

		accounts."andrieee44@gmail.com" = {
			address = "andrieee44@gmail.com";
			flavor = "gmail.com";
			passwordCommand = "${pkgs.pass}/bin/pass googleAppPasswords/neomutt";
			primary = true;
			realName = "andrieee44";
			userName = "andrieee44";
			maildir.path = "andrieee44@gmail.com";

			gpg = {
				key = "B936 149C 88D4 64B3 DC0B 9F0D A555 AF06 F5A8 0AB1";
				signByDefault = true;
			};

			signature = {
				delimiter = "-----";
				showSignature = "append";
				text = "\"The art of programming is the art of organizing complexity.\" -Edsger Dijkstra";
			};
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

	programs = {
		git.userEmail = "andrieee44@gmail.com";

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
