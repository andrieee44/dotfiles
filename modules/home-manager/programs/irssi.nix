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

		extraConfig = ''
			chatnets = {
				liberachat = {
					sasl_username = "andrieee44";
					sasl_password = "PASSWORD";
					sasl_mechanism = "PLAIN";
				};
			};

			dcc = {
				dcc_download_path = "${config.xdg.userDirs.download}";
				dcc_upload_path = "${config.xdg.userDirs.publicShare}";
			};

			lookandfeel = {
				timestamp_format = "%l:%M %p";
				timestamp_format_alt = "%b %e %Y (%a) %l:%M %p";
			};

			misc = {
				settings_autosave = "no";
			};
		'';
	};

	home = {
		file.".irssi/config".target = "${config.xdg.configHome}/irssi/base.config";

		shellAliases.irssi = "${pkgs.writers.writeDash "irssiPass" ''
			set -eu

			${pkgs.gawk}/bin/awk -v pass="$(${config.programs.password-store.package}/bin/pass web/liberachat)" '{
					sub("sasl_password = .*", "sasl_password = \"" pass "\";")
					print($0)
				}' "${config.home.homeDirectory}/${config.home.file.".irssi/config".target}" > "${config.xdg.configHome}/irssi/config"

			${pkgs.irssi}/bin/irssi --home "${config.xdg.configHome}/irssi" "$@"

			${pkgs.toybox}/bin/rm "${config.xdg.configHome}/irssi/config"
		''}";
	};
}
