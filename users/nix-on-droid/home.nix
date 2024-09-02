{ config, pkgs, stateVersion, ... }:
{
	home = {
		username = "nix-on-droid";
		homeDirectory = "/data/data/com.termux.nix/files/home";
		stateVersion = stateVersion;

		sessionVariables.SSH_ASKPASS = pkgs.writers.writeDash "ssh_askpass" ''
			set -eu

			${pkgs.pass}/bin/pass "ssh/oppoReno8Z"
		'';
	};
}
