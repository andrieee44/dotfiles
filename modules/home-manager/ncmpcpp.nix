{ config, pkgs, ... }:
{
	config.programs.ncmpcpp = {
		package = pkgs.ncmpcpp.override {
			visualizerSupport = true;
		};

		settings = {
			ncmpcpp_directory = "${config.xdg.configHome}/ncmpcpp";
			lyrics_directory = "${config.services.mpd.dataDir}/lyrics";
			mpd_host = "localhost";
			mpd_port = 6600;
			mpd_connection_timeout = 5;
			mpd_crossfade_time = 5;
			random_exclude_pattern = "^(temp|midi_songs).*";
			visualizer_data_source = "${config.services.mpd.dataDir}/visualizer.fifo";
			visualizer_output_name = "Visualizer Feed";
			visualizer_in_stereo = true;
			visualizer_type = "spectrum";
			visualizer_fps = 60;
			visualizer_autoscale = true;
			visualizer_look = "●█";
			visualizer_color = "blue, cyan, green, yellow, magenta, red";
			visualizer_spectrum_smooth_look = true;
			visualizer_spectrum_dft_size = 5;
			visualizer_spectrum_gain = 1;
			visualizer_spectrum_hz_min = 20;
			visualizer_spectrum_hz_max = 20000;
			playlist_disable_highlight_delay = 5;
			message_delay_time = 1;
			song_list_format = "{%a - %b - %t}|{%f}";
			song_status_format = "{%a - %b - %t}|{%f}";
			song_library_format = "{%n - }{%t}|{%f}";
			current_item_prefix = "$(magenta)$r$b";
			current_item_suffix = "$/b$/r$(end)";
			current_item_inactive_column_prefix = "$(blue)$r$b";
			current_item_inactive_column_suffix = "$/b$/r$(end)";
			now_playing_prefix = "$b";
			now_playing_suffix = "$/b";
			browser_playlist_prefix = "$2playlist$9 ";
			selected_item_prefix = "$6";
			selected_item_suffix = "$9";
			modified_item_prefix = "$3> $9";
			song_window_title_format = "{%a - %b - %t}|{%f}";
			browser_sort_mode = "type";
			browser_sort_format = "{%a - }{%t}|{%f} {%l}";
			song_columns_list_format = "(20)[]{a} (6f)[green]{NE} (50)[white]{t|f:Title} (20)[cyan]{b} (7f)[magenta]{l}";
			execute_on_song_change = "";
			execute_on_player_state_change = "";
			playlist_show_mpd_host = false;
			playlist_show_remaining_time = false;
			playlist_shorten_total_times = false;
			playlist_separate_albums = false;
			playlist_display_mode = "columns";
			browser_display_mode = "classic";
			search_engine_display_mode = "classic";
			playlist_editor_display_mode = "classic";
			discard_colors_if_item_is_selected = true;
			show_duplicate_tags = true;
			incremental_seeking = true;
			seek_time = 5;
			volume_change_step = 2;
			autocenter_mode = false;
			centered_cursor = false;
			progressbar_look = "=>";
			default_place_to_search_in = "database";
			user_interface = "classic";
			data_fetching_delay = true;
			media_library_primary_tag = "artist";
			media_library_albums_split_by_date = true;
			media_library_hide_album_dates = false;
			default_find_mode = "normal";
			default_tag_editor_pattern = "%n - %t";
			header_visibility = true;
			statusbar_visibility = true;
			connected_message_on_startup = true;
			titles_visibility = true;
			header_text_scrolling = true;
			cyclic_scrolling = false;
			lyrics_fetchers = "azlyrics, genius, musixmatch, sing365, metrolyrics, justsomelyrics, jahlyrics, plyrics, tekstowo, zeneszoveg, internet";
			follow_now_playing_lyrics = false;
			fetch_lyrics_for_current_song_in_background = false;
			store_lyrics_in_song_dir = false;
			generate_win32_compatible_filenames = false;
			allow_for_physical_item_deletion = false;
			lastfm_preferred_language = "en";
			space_add_mode = "add_remove";
			show_hidden_files_in_local_browser = true;
			screen_switcher_mode = "playlist, browser";
			startup_screen = "media_library";
			startup_slave_screen = "";
			startup_slave_screen_focus = false;
			locked_screen_width_part = 50;
			ask_for_locked_screen_width_part = true;
			jump_to_now_playing_song_at_start = true;
			ask_before_clearing_playlists = true;
			clock_display_seconds = false;
			display_volume_level = true;
			display_bitrate = false;
			display_remaining_time = false;
			regular_expressions = "basic";
			ignore_leading_the = false;
			ignore_diacritics = false;
			block_search_constraints_change_if_items_found = true;
			mouse_support = false;
			mouse_list_scroll_whole_page = false;
			lines_scrolled = 0;
			empty_tag_marker = "<empty>";
			tags_separator = " | ";
			tag_editor_extended_numeration = false;
			media_library_sort_by_mtime = false;
			enable_window_title = true;
			search_engine_default_search_mode = 1;
			external_editor = "$EDITOR";
			use_console_editor = true;
			colors_enabled = true;
			empty_tag_color = "cyan";
			header_window_color = "cyan";
			volume_color = "cyan:b";
			state_line_color = "cyan";
			state_flags_color = "cyan:b";
			main_window_color = "cyan";
			color1 = "white";
			color2 = "green";
			progressbar_color = "blue";
			progressbar_elapsed_color = "cyan:b";
			statusbar_color = "cyan";
			statusbar_time_color = "default:b";
			player_state_color = "default:b";
			alternative_ui_separator_color = "black:b";
			window_border_color = "green";
			active_window_border = "red";
		};

		bindings = [
			{ key = "h"; command = "previous_column"; }
			{ key = "j"; command = "scroll_down"; }
			{ key = "k"; command = "scroll_up"; }
			{ key = "l"; command = "next_column"; }
			{ key = "l"; command = "run_action"; }
			{ key = "l"; command = "play_item"; }
			{ key = "u"; command = "page_up"; }
			{ key = "d"; command = "page_down"; }
			{ key = "+"; command = "show_clock"; }
			{ key = "v"; command = "show_visualizer"; }
			{ key = "m"; command = "show_media_library"; }
		];
	};
}
