{ config, lib, ... }:
{
	options.stylix.targets.custom.aerc.enable = lib.mkEnableOption "custom implementation for stylix.targets.aerc";

	config.programs.aerc.stylesets.default = lib.mkIf config.stylix.targets.custom.aerc.enable ''
		*.selected.bg=8
		*.selected.bold=true
		statusline_default.bold=true
		border.reverse=false
		part_mimetype.dim=false

		border.fg=3
		error.fg=1
		warning.fg=3
		success.fg=2
		statusline_default.bg=0
		statusline_default.fg=4
		statusline_error.fg=1
		statusline_warning.fg=3
		msglist_deleted.fg=8
		msglist_deleted.selected.fg=8
		msglist_deleted.selected.bg=0
		msglist_result.fg=2
		msglist_result.selected.fg=2
		msglist_result.selected.bg=0
		msglist_marked.fg=4
		msglist_marked.selected.fg=4
		msglist_marked.selected.bg=0
		msglist_flagged.fg=2
		msglist_flagged.selected.fg=2
		msglist_flagged.selected.bg=0
		msglist_unread.fg=6
		msglist_unread.selected.fg=6
		msglist_unread.selected.bg=0
		tab.fg=8
		tab.bg=7
		tab.selected.bg=4
		tab.selected.fg=0
		dirlist_unread.fg=4
		dirlist_unread.selected.fg=4
		dirlist_unread.selected.bg=0
		dirlist_recent.fg=4
		dirlist_recent.selected.fg=4
		dirlist_recent.selected.bg=0
		part_mimetype.fg=7
		part_mimetype.bg=8
		part_mimetype.selected.fg=4
		part_mimetype.selected.bg=0
		part_switcher.bg=8
		part_switcher.selected.fg=4
	'';
}
