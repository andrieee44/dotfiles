{ config, colorscheme, ... }:
{
	programs.aerc = {
		extraConfig = {
			filters."text/plain" = "colorize";
			general.unsafe-accounts-conf = true;
			viewer.pager = config.home.sessionVariables.PAGER;

			ui = {
				border-char-vertical = "│";
				border-char-horizontal = "─";
			};
		};

		stylesets.default = ''
			*.default=true
			*.normal=true

			default.fg = #${colorscheme.palette.base05}

			error.fg = #${colorscheme.palette.base00}
			error.bg = #${colorscheme.palette.base08}
			error.bold = true

			warning.fg = #${colorscheme.palette.base00}
			warning.bg = #${colorscheme.palette.base0A}
			warning.bold = true

			success.fg = #${colorscheme.palette.base00}
			success.bg = #${colorscheme.palette.base0B}
			success.bold = true

			title.fg = #${colorscheme.palette.base00}
			title.bg = #${colorscheme.palette.base0C}
			title.bold = true

			header.fg = #${colorscheme.palette.base00}
			header.bg = #${colorscheme.palette.base0C}
			header.bold = true

			msglist_*.selected.fg = #${colorscheme.palette.base00}
			msglist_*.selected.bg = #${colorscheme.palette.base0C}
			msglist_*.selected.bold = true

			msglist_default.fg = #${colorscheme.palette.base05}

			msglist_unread.fg = #${colorscheme.palette.base05}
			msglist_unread.bold = true

			msglist_read.fg = #${colorscheme.palette.base05}

			msglist_flagged.fg = #${colorscheme.palette.base0A}
			msglist_flagged.bg = #${colorscheme.palette.base0A}

			msglist_deleted.fg = #${colorscheme.palette.base08}
			msglist_deleted.bg = #${colorscheme.palette.base08}

			msglist_marked.fg = #${colorscheme.palette.base0E}

			msglist_result.fg = #${colorscheme.palette.base05}
			msglist_result.bg = #${colorscheme.palette.base0C}

			msglist_answered.fg = #${colorscheme.palette.base0B}
			msglist_answered.selected.bg = #${colorscheme.palette.base0B}

			msglist_gutter.fg = #${colorscheme.palette.base08}
			msglist_gutter.bg = #${colorscheme.palette.base0C}

			msglist_pill.fg = #${colorscheme.palette.base08}
			msglist_pill.bg = #${colorscheme.palette.base0C}

			msglist_thread_folded.fg = #${colorscheme.palette.base08}
			msglist_thread_folded.bg = #${colorscheme.palette.base0C}

			dirlist_*.selected.fg = #${colorscheme.palette.base00}
			dirlist_*.selected.bg = #${colorscheme.palette.base0C}
			dirlist_*.selected.bold = true

			dirlist_default.fg = #${colorscheme.palette.base05}

			dirlist_unread.fg = #${colorscheme.palette.base08}
			dirlist_unread.bold = true

			dirlist_recent.fg = #${colorscheme.palette.base08}
			dirlist_recent.bg = #${colorscheme.palette.base0C}
			dirlist_recent.bold = true

			part_*.selected.fg = #${colorscheme.palette.base00}
			part_*.selected.bg = #${colorscheme.palette.base0C}
			part_*.selected.bold = true

			tab.fg = #${colorscheme.palette.base05}
			tab.bg = #${colorscheme.palette.base03}
			tab.selected.fg = #${colorscheme.palette.base00}
			tab.selected.bg = #${colorscheme.palette.base0C}
			tab.selected.bold = true

			stack.fg = #${colorscheme.palette.base08}
			stack.bg = #${colorscheme.palette.base0C}
			stack.selected.fg = #${colorscheme.palette.base08}
			stack.selected.bg = #${colorscheme.palette.base0C}

			border.fg = #${colorscheme.palette.base0C}

			statusline_*.bold = true

			statusline_default.fg = #${colorscheme.palette.base00}
			statusline_default.bg = #${colorscheme.palette.base0C}

			statusline_error.fg = #${colorscheme.palette.base00}
			statusline_error.bg = #${colorscheme.palette.base08}

			statusline_warning.fg = #${colorscheme.palette.base00}
			statusline_warning.bg = #${colorscheme.palette.base0A}

			statusline_success.fg = #${colorscheme.palette.base00}
			statusline_success.bg = #${colorscheme.palette.base0B}
		'';
	};
}
