{ ... }:
{
	services.gpg-agent = {
		pinentryFlavor = "tty";
		defaultCacheTtl = 86400;
		extraConfig = "allow-preset-passphrase";
	};
}
