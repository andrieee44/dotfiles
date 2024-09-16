{ config, pkgs, ... }:
{
	programs.irssi = {
		networks.liberachat = {
			nick = "andrieee44";

			server = {
				address = "irc.libera.chat";
				port = 6697;
				autoConnect = true;
			};
		};
	};

	home.shellAliases.irssi = "${pkgs.writers.writeDash "irssiPass" ''
		set -eu

		${pkgs.irssi}/bin/irssi -w "$(${pkgs.pass}/bin/pass web/liberachat)"
	''}";
}
