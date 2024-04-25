{ pkgs, ... }:
{
	services.gpg-agent = {
		defaultCacheTtl = 0;
		extraConfig = "allow-preset-passphrase";
		pinentryPackage = pkgs.pinentry-tty;
	};
}
