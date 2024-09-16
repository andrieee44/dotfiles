{ config, lib, ... }:
{
	options.stylix.targets.custom.aerc.enable = lib.mkEnableOption "custom implementation of styling aerc";

	config.programs.aerc.stylesets.default = let
		colors = config.lib.stylix.colors.withHashtag;
	in lib.mkIf config.stylix.targets.custom.aerc.enable ''
		*.selected.bold=true
		statusline_default.bold=true
		border.reverse=false
		part_mimetype.dim=false

		error.fg=${colors.base00}
		warning.fg=${colors.base00}
		success.fg=${colors.base00}
		title.fg=${colors.base0D}
		title.bg=${colors.base00}
		statusline_default.fg=${colors.base00}
		statusline_default.bg=${colors.base0D}
		statusline_error.bg=${colors.base08}
		statusline_warning.bg=${colors.base0A}
		statusline_success.bg=${colors.base0B}
		msglist_default.fg=${colors.base05}
		msglist_default.selected.fg=${colors.base00}
		msglist_default.selected.bg=${colors.base05}
		msglist_read.fg=${colors.base05}
		msglist_read.selected.fg=${colors.base00}
		msglist_read.selected.bg=${colors.base05}
		msglist_deleted.fg=${colors.base08}
		msglist_deleted.selected.fg=${colors.base00}
		msglist_deleted.selected.bg=${colors.base08}
		msglist_result.fg=${colors.base0B}
		msglist_result.selected.fg=${colors.base00}
		msglist_result.selected.bg=${colors.base0B}
		msglist_marked.fg=${colors.base0D}
		msglist_marked.selected.fg=${colors.base00}
		msglist_marked.selected.bg=${colors.base0D}
		msglist_flagged.fg=${colors.base0B}
		msglist_flagged.selected.fg=${colors.base00}
		msglist_flagged.selected.bg=${colors.base0B}
		msglist_unread.fg=${colors.base0E}
		msglist_unread.selected.fg=${colors.base00}
		msglist_unread.selected.bg=${colors.base0E}
		tab.fg=${colors.base05}
		tab.bg=${colors.base03}
		tab.selected.bg=${colors.base0D}
		tab.selected.fg=${colors.base00}
		dirlist_default.selected.fg=${colors.base00}
		dirlist_default.selected.bg=${colors.base05}
		dirlist_unread.fg=${colors.base0E}
		dirlist_unread.selected.fg=${colors.base00}
		dirlist_unread.selected.bg=${colors.base0E}
		dirlist_recent.fg=${colors.base0D}
		dirlist_recent.selected.fg=${colors.base00}
		dirlist_recent.selected.bg=${colors.base0D}
		part_mimetype.fg=${colors.base05}
		part_mimetype.bg=${colors.base03}
		part_mimetype.selected.fg=${colors.base00}
		part_mimetype.selected.bg=${colors.base0D}
		part_switcher.bg=${colors.base03}
		part_switcher.selected.bg=${colors.base0D}
		completion_default.fg=${colors.base05}
		completion_default.bg=${colors.base03}
		completion_default.selected.fg=${colors.base00}
		completion_default.selected.bg=${colors.base0D}
	'';
}
