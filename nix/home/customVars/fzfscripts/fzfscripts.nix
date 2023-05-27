{ config, pkgs, options, ... }:
{
	options.customVars.fzfscripts = let
		mkPkgOption = config.customVars.mkPkgOption;
	in
	{
		pathmenu = mkPkgOption "pathmenu";
	};

	config.customVars.fzfscripts = {
		pathmenu = pkgs.writeScriptBin "pathmenu" ''#!${pkgs.dash}/bin/dash
			set -eu
			bin=""
			IFS=:
			for d in $PATH; do
				[ ! -d "$d" ] && continue
				bin="${"\${bin}"}$(${pkgs.busybox}/bin/find -L "$d" -mindepth 1 -type f -perm -u=x -not -name '.*')"
			done

			cmd="$(echo "$bin" | ${pkgs.busybox}/bin/sed 's/.*\///' | ${pkgs.busybox}/bin/sort | ${pkgs.fzf}/bin/fzf-tmux)"

			[ ! -t 1 ] && echo "$cmd" && exit
			eval "$cmd"
		'';
	};
}
