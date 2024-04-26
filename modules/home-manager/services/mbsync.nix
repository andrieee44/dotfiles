{ config, pkgs, lib, ... }:
{
	systemd.user.timers.mbsync.Unit.After = [ "network-online.target" ];

	systemd.user.services.mbsync.Service.Environment = lib.mkIf config.services.mbsync.enable [
		"PASSWORD_STORE_DIR=${config.programs.password-store.settings.PASSWORD_STORE_DIR}"
		"GNUPGHOME=${config.programs.gpg.homedir}"
	];

	services.mbsync = {
		frequency = "*:0/15";
		postExec = "${pkgs.notmuch}/bin/notmuch new";
	};
}
