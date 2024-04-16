{ pkgs, ... }:
{
	services.gpg-agent = {
		defaultCacheTtl = 86400;
		extraConfig = "allow-preset-passphrase";
		pinentryPackage = pkgs.pinentry-tty;
	};
}
