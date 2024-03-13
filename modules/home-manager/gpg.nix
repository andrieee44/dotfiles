{ config, ... }:
{
	programs.gpg = {
		homedir = "${config.xdg.dataHome}/gnupg";
		mutableKeys = false;
		mutableTrust = false;
	};

	accounts.email.accounts."${config.home.username}".gpg.signByDefault = true;

	services.gpg-agent = {
		pinentryFlavor = "tty";
		defaultCacheTtl = 86400;
		extraConfig = "allow-preset-passphrase";
	};
}
