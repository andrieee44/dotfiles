{ pkgs, ... }:
{
	services.gpg-agent = {
		defaultCacheTtl = 34560000;
		extraConfig = "allow-preset-passphrase";
		pinentryPackage = pkgs.pinentry-tty;
	};
}
