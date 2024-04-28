{ config, pkgs, lib, ... }:
{
	programs.aerc = {
		extraConfig = {
			filters."text/plain" = "colorize";
			viewer.pager = config.home.sessionVariables.PAGER;

			general = {
				term = "linux";
				unsafe-accounts-conf = true;
			};

			ui = {
				border-char-vertical = "│";
				border-char-horizontal = "─";
			};
		};

		stylesets.default = ''
			*.default=true
			*.normal=true

			default.fg = 7

			error.fg = 0
			error.bg = 1
			error.bold = true

			warning.fg = 0
			warning.bg = 3
			warning.bold = true

			success.fg = 0
			success.bg = 2
			success.bold = true

			title.fg = 0
			title.bg = 6
			title.bold = true

			header.fg = 0
			header.bg = 6
			header.bold = true

			msglist_*.selected.fg = 0
			msglist_*.selected.bg = 6
			msglist_*.selected.bold = true

			msglist_default.fg = 7

			msglist_unread.fg = 7
			msglist_unread.bold = true

			msglist_read.fg = 7

			msglist_flagged.fg = 3
			msglist_flagged.bg = 3

			msglist_deleted.fg = 1
			msglist_deleted.bg = 1

			msglist_marked.fg = 5

			msglist_result.fg = 7
			msglist_result.bg = 6

			msglist_answered.fg = 2
			msglist_answered.selected.bg = 2

			msglist_gutter.fg = 1
			msglist_gutter.bg = 6

			msglist_pill.fg = 1
			msglist_pill.bg = 6

			msglist_thread_folded.fg = 1
			msglist_thread_folded.bg = 6

			dirlist_*.selected.fg = 0
			dirlist_*.selected.bg = 6
			dirlist_*.selected.bold = true

			dirlist_default.fg = 7

			dirlist_unread.fg = 1
			dirlist_unread.bold = true

			dirlist_recent.fg = 1
			dirlist_recent.bg = 6
			dirlist_recent.bold = true

			part_*.selected.fg = 0
			part_*.selected.bg = 6
			part_*.selected.bold = true

			tab.fg = 7
			tab.bg = 8
			tab.selected.fg = 0
			tab.selected.bg = 6
			tab.selected.bold = true

			stack.fg = 1
			stack.bg = 6
			stack.selected.fg = 1
			stack.selected.bg = 6

			border.fg = 6

			statusline_*.bold = true

			statusline_default.fg = 0
			statusline_default.bg = 6

			statusline_error.fg = 0
			statusline_error.bg = 1

			statusline_warning.fg = 0
			statusline_warning.bg = 3

			statusline_success.fg = 0
			statusline_success.bg = 2
		'';
	};

	home = lib.mkIf config.programs.aerc.enable {
		file."${config.xdg.configHome}/aerc/aerc.conf".target = "${config.xdg.configHome}/aerc/base.conf";

		shellAliases.aerc = "${pkgs.writers.writeDash "aercConf" ''
			set -eu

			${pkgs.busybox}/bin/awk -v term="${"\${TERM}"}" '{
				gsub("term = .*", "term = " term)
				print($0)
			}' '${config.home.homeDirectory}/${config.home.file."${config.xdg.configHome}/aerc/aerc.conf".target}' > '${config.xdg.configHome}/aerc/aerc.conf'

			${pkgs.aerc}/bin/aerc
		''}";
	};
}
