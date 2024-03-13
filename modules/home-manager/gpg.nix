{ config, ... }:
{
	accounts.email.accounts."${config.home.username}".gpg.signByDefault = true;

	programs.gpg = {
		homedir = "${config.xdg.dataHome}/gnupg";
		mutableKeys = false;
		mutableTrust = false;
	};

	services.gpg-agent = {
		pinentryFlavor = "tty";
		defaultCacheTtl = 86400;
		extraConfig = "allow-preset-passphrase";
	};
}
