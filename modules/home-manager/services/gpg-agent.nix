{ config, pkgs, ... }:
{
	services.gpg-agent = {
		defaultCacheTtl = 34560000;
		pinentryPackage = pkgs.pinentry-tty;

		extraConfig = ''
			allow-preset-passphrase
			max-cache-ttl ${builtins.toString config.services.gpg-agent.defaultCacheTtl}
		'';
	};
}
