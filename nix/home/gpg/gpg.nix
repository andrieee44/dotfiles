{ config, ... }:
{
	config = {
		programs.gpg = {
			homedir = "${config.xdg.dataHome}/gnupg";
			mutableKeys = false;
			mutableTrust = false;

			publicKeys = [
				{
					text = ''
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=YxZg
-----END PGP PUBLIC KEY BLOCK-----
					'';
					trust = 5;
				}
			];
		};

		accounts.email.accounts."${config.customVars.user}".gpg = {
			key = "B936 149C 88D4 64B3 DC0B 9F0D A555 AF06 F5A8 0AB1";
			signByDefault = true;
		};

		services.gpg-agent = {
			pinentryFlavor = "tty";
			enableSshSupport = false;
			defaultCacheTtl = 86400;

			extraConfig = ''
				allow-preset-passphrase
			'';
		};

		home.file.pam-gnupg = {
			executable = false;
			target = "${config.xdg.configHome}/pam-gnupg";
			text = ''
				${config.programs.gpg.homedir}
				4761373E4C1DF3223D5D82B64B2B4D7665A3138B
			'';
		};
	};
}
