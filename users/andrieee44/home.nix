{ config, pkgs, ... }:
{
	accounts.email = {
		maildirBasePath = "${config.xdg.dataHome}/maildir";

		accounts."andrieee44@gmail.com" = let
			signatureText = "-- \n\"The art of programming is the art of organizing complexity.\" -Edsger Dijkstra";
		in {
			address = "andrieee44@gmail.com";
			flavor = "gmail.com";
			passwordCommand = "${pkgs.pass}/bin/pass web/gmailApp";
			primary = true;
			realName = "andrieee44";
			userName = "andrieee44";
			maildir.path = "andrieee44@gmail.com";

			msmtp.enable = true;
			notmuch.enable = true;

			aerc = {
				enable = true;
				extraAccounts.signature-file = builtins.toFile "signature.txt" signatureText;
			};

			gpg = {
				key = "B936 149C 88D4 64B3 DC0B 9F0D A555 AF06 F5A8 0AB1";
				signByDefault = true;
			};

			mbsync = {
				enable = true;
				create = "maildir";
				expunge = "maildir";
				subFolders = "Maildir++";
			};

			signature = {
				text = signatureText;
				showSignature = "append";
			};
		};
	};

	home = {
		username = "andrieee44";
		homeDirectory = "/home/${config.home.username}";

		sessionVariables.SSH_ASKPASS = pkgs.writers.writeDash "ssh_askpass" ''
			set -eu

			${pkgs.pass}/bin/pass "ssh/lenovoIdeapadSlim3"
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
