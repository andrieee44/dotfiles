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

		shShebang = config.customVars.shShebang;
		unixUtils = config.customVars.unixUtils;
	in
	{
		pathmenu = pkgs.writeScriptBin "pathmenu" ''${shShebang}
			bin=""
			IFS=:
			for d in $PATH; do
				[ ! -d "$d" ] && continue
				bin="${"\${bin}"}$(${unixUtils}/find -L "$d" -mindepth 1 -type f -perm -u=x -not -name '.*')"
			done

			cmd="$(echo "$bin" | ${unixUtils}/sed 's/.*\///' | ${unixUtils}/sort | ${pkgs.fzf}/bin/fzf-tmux --header "Search executable:" ${fzf-tmuxArgs})"

			[ ! -t 1 ] && echo "$cmd" && exit
			eval "$cmd"
		'';

		sysmenu = pkgs.writeScriptBin "sysmenu" ''${shShebang}
			arr='
				lock ; ${pkgs.systemd}/bin/loginctl lock-session
				reload ; ${pkgs.sway}/bin/swaymsg reload
				leave ; ${pkgs.sway}/bin/swaymsg exit
				poweroff ; ${pkgs.systemd}/bin/poweroff
				reboot ; ${pkgs.systemd}/bin/reboot
			'

			cmd="$(echo "$arr" | ${unixUtils}/sed -n '
				s/^[[:space:]]*\(.\+\)[[:space:]]*;.*$/\1/p
			' | ${pkgs.fzf}/bin/fzf-tmux --header "System action:" ${fzf-tmuxArgs})"

			err="$?"
			[ "$err" -ne 0 ] && exit "$err"

			eval "$(echo "$arr" | ${unixUtils}/sed -n '
				/'"${"\${cmd}"}"'/ {
					s/^[[:space:]]*'"${"\${cmd}"}"'[[:space:]]*;[[:space:]]*\(.\+\)[[:space:]]*$/\1/p
					q
				}
			')"
		'';
	};
}
