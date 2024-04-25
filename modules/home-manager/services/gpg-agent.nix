{ pkgs, ... }:
{
	services.gpg-agent = {
		extraConfig = "allow-preset-passphrase";
		pinentryPackage = pkgs.pinentry-tty;
	};
}
