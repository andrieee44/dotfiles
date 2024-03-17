{ config, pkgs, lib, ... }:
{
	options.sh = let
		pkgOpt = lib.mkOption { type = lib.types.package; };
	in {
		pathmenu = pkgOpt;
		sysmenu = pkgOpt;
	};

	config.sh = {
		pathmenu = pkgs.writers.writeDash "pathmenu" ''
			set -eu
			tmpfile=$(${pkgs.toybox}/bin/mktemp /tmp/pathmenu.XXXXXX)
			exec 3> "$tmpfile"
			exec 4< "$tmpfile"
			rm "$tmpfile"

			IFS=:
			for d in $PATH; do
				[ ! -d "$d" ] && continue
				${pkgs.toybox}/bin/find -L "$d" -mindepth 1 -maxdepth 1 -type f -perm -u=x -not -name '.*' -printf "%f\n" >& 3
			done

			${pkgs.toybox}/bin/sort <& 4 | ${pkgs.fzf}/bin/fzf-tmux --header "Search executable:" -p 45%,60% --border=sharp
			exec 3>& -
		'';

		sysmenu = pkgs.writers.writeDash "pathmenu" ''
			set -eu
			arr='
				leave desktop session = ${pkgs.systemd}/bin/loginctl kill-session self
				poweroff computer = ${pkgs.systemd}/bin/poweroff
				reboot computer = ${pkgs.systemd}/bin/reboot
				lock desktop session = ${pkgs.systemd}/bin/loginctl lock-session
				reload window manager = ${lib.optionalString config.wayland.windowManager.sway.enable "${pkgs.sway}/bin/swaymsg reload"}
			'

			cmd="$(echo "$arr" | ${pkgs.busybox}/bin/awk -F '=' '
				NF == 2 {
					gsub("^[[:space:]]*", "", $1)
					print($1)
				}
			' | ${pkgs.fzf}/bin/fzf-tmux --header "System action:" -p 45%,60% --border=sharp)"

			err="$?"
			[ "$err" -ne 0 ] && exit "$err"

			eval "$(echo "$arr" | ${pkgs.busybox}/bin/awk -F '=' -v cmd="${"\${cmd}"}" '
				NF == 2 && match($0, cmd) {
					print($2)
				}
			')"
		'';
	};
}
