{ config, pkgs, options, ... }:
{
	options.customVars.fzfscripts = let
		mkPkgOption = config.customVars.mkPkgOption;
	in
	{
		pathmenu = mkPkgOption "pathmenu";
	};

	config = {
		programs.fzf = {
			defaultOptions = [
				"--exact"
				"--reverse"
				"--info inline"
				"--header-first"
				"--header 'Search file'"
				"--tabstop 4"
				"--no-mouse"
				"--preview-window border-left,wrap"
			];

			colors = {
				"bg+" = "#3b4252";
				spinner = "#81a1c1";
				hl = "#616e88";
				fg = "#d8dee9";
				header = "#81a1c1";
				info = "#88c0d0";
				pointer = "#81a1c1";
				marker = "#81a1c1";
				"fg+" = "#d8dee9";
				prompt = "#81a1c1";
				"hl+" = "#81a1c1";
			};
		};

		customVars.fzfscripts = {
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
	};
}
