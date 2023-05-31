{ config, pkgs, options, ... }:
{
	options.customVars.fzfscripts = let
		mkPkgOption = config.customVars.mkPkgOption;
	in
	{
		pathmenu = mkPkgOption "pathmenu";
		sysmenu = mkPkgOption "sysmenu";
	};

	config.customVars.fzfscripts = let
		fzf-tmuxArgs = ''
			-p "45%,60%" $(set +u && [ -n "$TMUX" ] && echo "--border=sharp")
		'';
	in
	{
		pathmenu = pkgs.writeScriptBin "pathmenu" ''#!${pkgs.dash}/bin/dash
			set -eu
			bin=""
			IFS=:
			for d in $PATH; do
				[ ! -d "$d" ] && continue
				bin="${"\${bin}"}$(${pkgs.busybox}/bin/find -L "$d" -mindepth 1 -type f -perm -u=x -not -name '.*')"
			done

			cmd="$(echo "$bin" | ${pkgs.busybox}/bin/sed 's/.*\///' | ${pkgs.busybox}/bin/sort | ${pkgs.fzf}/bin/fzf-tmux --header "Search executable:" ${fzf-tmuxArgs})"

			[ ! -t 1 ] && echo "$cmd" && exit
			eval "$cmd"
		'';

		sysmenu = pkgs.writeScriptBin "sysmenu" ''#!${pkgs.dash}/bin/dash
			set -eu
			arr='
				shutdown ; ${pkgs.systemd}/bin/loginctl shutdown
				reboot ; ${pkgs.systemd}/bin/loginctl reboot
				lock ; ${pkgs.systemd}/bin/loginctl lock-session
				reload ; ${pkgs.sway}/bin/swaymsg reload
				leave ; ${pkgs.sway}/bin/swaymsg exit
			'

			cmd="$(echo "$arr" | ${pkgs.busybox}/bin/sed -n '
				/^$/ d
				s/[[:space:]]*\(.\+\)[[:space:]]*;.*/\1/p
			' | ${pkgs.fzf}/bin/fzf-tmux --header "System action:" ${fzf-tmuxArgs})"

			err="$?"
			[ "$err" -ne 0 ] && exit "$err"

			eval "$(echo "$arr" | ${pkgs.busybox}/bin/awk -v "cmd=${"\${cmd}"}" '
				BEGIN {
					FS = ";"
				}
				{
					if ($1 == cmd) {
						print $2
					}
				}
			')"
		'';
	};
}
