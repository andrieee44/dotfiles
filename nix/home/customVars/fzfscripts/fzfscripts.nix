{ config, pkgs, lib, ... }:
{
	options.customVars.fzfscripts = let
		mkPkgOption = config.customVars.mkOption lib.types.package;
	in {
		pathmenu = mkPkgOption;
		sysmenu = mkPkgOption;
		preview = mkPkgOption;
	};

	config.customVars.fzfscripts = let
		shShebang = config.customVars.shShebang;
		unixUtils = config.customVars.unixUtils;
		awk = "${pkgs.gawk}/bin/awk";

		fzf-tmux = header:
			''${pkgs.fzf}/bin/fzf-tmux --header "${header}" -p "45%,60%" $(set +u && [ -n "$TMUX" ] && echo "--border=sharp")'';
	in {
		pathmenu = pkgs.writeScriptBin "pathmenu" ''${shShebang}
			tmpfile=$(${unixUtils}/mktemp /tmp/pathmenu.XXXXXX)
			exec 3> "$tmpfile"
			exec 4< "$tmpfile"
			rm "$tmpfile"

			IFS=:
			for d in $PATH; do
				[ ! -d "$d" ] && continue
				${unixUtils}/find -L "$d" -mindepth 1 -maxdepth 1 -type f -perm -u=x -not -name '.*' -printf "%f\n" >& 3
			done

			${unixUtils}/sort <& 4 | ${fzf-tmux "Search executable:"}
			exec 3>& -
		'';

		sysmenu = let
			systemd = "${pkgs.systemd}/bin";
		in pkgs.writeScriptBin "sysmenu" ''${shShebang}
			arr='
				leave desktop session = ${systemd}/loginctl kill-session self
				poweroff computer = ${systemd}/poweroff
				reboot computer = ${systemd}/reboot
				lock desktop session = ${systemd}/loginctl lock-session
				reload window manager = ${lib.optionalString config.wayland.windowManager.sway.enable "${pkgs.sway}/bin/swaymsg reload"}
			'

			cmd="$(echo "$arr" | ${awk} '
				BEGIN {
					FS = "="
				}

				NF == 2 {
					gsub("^[[:space:]]*", "", $1)
					print($1)
				}
			' | ${fzf-tmux "System action:"})"

			err="$?"
			[ "$err" -ne 0 ] && exit "$err"

			eval "$(echo "$arr" | ${awk} -v cmd="${"\${cmd}"}" '
				BEGIN {
					FS = "="
				}

				NF == 2 && match($0, cmd) {
					print($2)
				}
			')"
		'';
	};
}
