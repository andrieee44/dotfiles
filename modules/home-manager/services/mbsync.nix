{ config, pkgs, lib, ... }:
{
	systemd.user.timers.mbsync.Unit.After = [ "network-online.target" ];

	systemd.user.services.mbsync.Service = {
		ExecStart = lib.mkForce "-${pkgs.isync}/bin/mbsync --all --verbose";

		Environment = lib.mkIf config.services.mbsync.enable [
			"PASSWORD_STORE_DIR=${config.programs.password-store.settings.PASSWORD_STORE_DIR}"
			"GNUPGHOME=${config.programs.gpg.homedir}"
		];
	};

	services.mbsync = {
		frequency = "*:0/15";
		postExec = "-${pkgs.writers.writeDash "postdelivery" ''
			set -eu

			unread="$(${pkgs.mu}/bin/mu find 'flag:unread' | ${pkgs.toybox}/bin/wc -l)"
			${pkgs.notmuch}/bin/notmuch new
			[ "$unread" -ne 0 ] && ${pkgs.notify-desktop}/bin/notify-desktop "You have ${"\${unread}"} unread emails" "wip"
		''}";
	};
}
