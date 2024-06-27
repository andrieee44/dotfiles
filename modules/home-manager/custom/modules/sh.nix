{ config, pkgs, lib, ... }:
{
	options.custom.sh = {
		bookmarks = lib.mkOption {
			type = lib.types.package;

			default = pkgs.writers.writeDashBin "bookmarks" ''
				set -eu

				${config.custom.programs.cmenu.package}/bin/cmenu \
				'${pkgs.fzf}/bin/fzf --header "󰃀 Bookmarks 󰃀"' \
				${config.home.homeDirectory}/${config.xdg.dataFile."cmenu/bookmarks.json".target} \
				| {
					[ -n "$WAYLAND_DISPLAY" ] && ${pkgs.wl-clipboard}/bin/wl-copy -n && return
					[ -n "$TMUX" ] && ${pkgs.toybox}/bin/echo -e '\e]52;c;'"$(${pkgs.toybox}/bin/base64)"'\a'
				}
			'';
		};
	};
}
