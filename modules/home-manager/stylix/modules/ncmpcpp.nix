{ config, lib, ... }:
{
	options.stylix.targets.custom.ncmpcpp.enable = lib.mkEnableOption "custom implementation of styling ncmpcpp";

	config = lib.mkIf config.stylix.targets.custom.ncmpcpp.enable {
		programs.ncmpcpp.settings = let
			fmt = "{%A - %n - %b - %t}|{%f}";
			mpd = config.services.mpd;
		in {
			visualizer_data_source = "${mpd.dataDir}/visualizer.fifo";
			visualizer_output_name = "Visualizer Feed";
			visualizer_in_stereo = true;
			visualizer_autoscale = true;
			visualizer_look = "*█";
			playlist_show_mpd_host = true;
			playlist_show_remaining_time = true;
			playlist_shorten_total_times = true;
			browser_display_mode = "columns";
			search_engine_display_mode = "columns";
			playlist_editor_display_mode = "columns";
			user_interface = "alternative";
			display_bitrate = true;
			empty_tag_marker = "<empty>";
			tags_separator = " | ";
			song_list_format = fmt;
			song_status_format = fmt;
			song_library_format = "{%n - %t}|{%f}";
			alternative_header_first_line_format = "";
			alternative_header_second_line_format = "$b{$(magenta)%A$(end) - $(green)%n$(end) - $(blue)%b$(end) - $(cyan)%t$(end)}|{$(cyan)%f$(end)}$/b";
			current_item_prefix = "$(blue)$b$r";
			current_item_suffix = "$/b$/r$(end)";
			current_item_inactive_column_prefix = "$(white)$b$r";
			current_item_inactive_column_suffix = "$/b$/r$(end)";
			now_playing_prefix = "$b$u$(red)> $(end)";
			now_playing_suffix = "$/b$/u";
			browser_playlist_prefix = "$(blue)Playlist: $(end)";
			selected_item_prefix = "$(magenta)$b";
			selected_item_suffix = "$/b$(end)";
			modified_item_prefix = "$(green)> $(end)";
			song_window_title_format = fmt;
			browser_sort_format = fmt;
			song_columns_list_format = "(33)[magenta]{A} (6f)[green]{n} (33)[blue]{b} (34)[cyan]{t|f:Title}";
			default_tag_editor_pattern = fmt;
			progressbar_look = "=>-";
			empty_tag_color = "yellow";
			header_window_color = "blue";
			volume_color = "blue:b";
			state_line_color = "blue";
			state_flags_color = "blue:b";
			main_window_color = "blue";
			color1 = "blue";
			color2 = "green";
			progressbar_color = "blue";
			progressbar_elapsed_color = "blue:b";
			statusbar_color = "blue";
			statusbar_time_color = "blue:b";
			player_state_color = "blue:b";
			alternative_ui_separator_color = "blue";
			window_border_color = "blue";
			active_window_border = "blue";
		};

		services.mpd.extraConfig = let
			cfg = config.programs.ncmpcpp;
		in lib.mkIf cfg.enable ''
			audio_output {
				type "fifo"
				name "${cfg.settings.visualizer_output_name}"
				path "${cfg.settings.visualizer_data_source}"
				format "${if cfg.settings.visualizer_in_stereo then "44100:16:2" else "44100:16:1"}"
			}
		'';
	};
}
