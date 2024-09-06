{ pkgs, lib, ... }:
{
	home = {
		username = "nix-on-droid";
		homeDirectory = "/data/data/com.termux.nix/files/home";

		sessionVariables.SSH_ASKPASS = pkgs.writers.writeDash "ssh_askpass" ''
			set -eu

			${pkgs.pass}/bin/pass "ssh/oppoReno8Z"
		'';
	};

	programs = {
		mbsync.enable = lib.mkForce false;
		msmtp.enable = lib.mkForce false;
		notmuch.enable = lib.mkForce false;
	};

	services = {
		gpg-agent.enable = lib.mkForce false;
		mbsync.enable = lib.mkForce false;
		mpd.enable = lib.mkForce false;
	};
}
