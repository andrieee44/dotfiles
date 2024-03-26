{ ... }:
{
	services.gpg-agent = {
		defaultCacheTtl = 86400;
		extraConfig = "allow-preset-passphrase";
	};
}
