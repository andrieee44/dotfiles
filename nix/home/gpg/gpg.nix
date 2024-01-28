{ config, ... }:
{
	config = {
		programs.gpg = {
			homedir = "${config.xdg.dataHome}/gnupg";
			mutableKeys = false;
			mutableTrust = false;

			publicKeys = [
				{
					trust = 5;
					source = ./andrieee44-public.key;
				}
			];
		};

		accounts.email.accounts."${config.home.username}".gpg = {
			key = "B936 149C 88D4 64B3 DC0B 9F0D A555 AF06 F5A8 0AB1";
			signByDefault = true;
		};

		services.gpg-agent = {
			pinentryFlavor = "tty";
			defaultCacheTtl = 86400;

			extraConfig = ''
				allow-preset-passphrase
			'';
		};

		xdg.configFile.pam-gnupg = {
			enable = config.services.gpg-agent.enable;
			target = "pam-gnupg";

			text = ''
				${config.programs.gpg.homedir}
				4761373E4C1DF3223D5D82B64B2B4D7665A3138B
			'';
		};
	};
}
