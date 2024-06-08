{ config, pkgs, ... }:
{
	programs.ncmpcpp = {
		package = pkgs.ncmpcpp.override { visualizerSupport = true; };

		settings = let
			mpd = config.services.mpd;
		in {
			ncmpcpp_directory = "${config.xdg.configHome}/ncmpcpp";
			lyrics_directory = "${mpd.dataDir}/lyrics";
			mpd_host = mpd.network.listenAddress;
			mpd_port = mpd.network.port;
			mpd_connection_timeout = 5;
			mpd_crossfade_time = 5;
			random_exclude_pattern = "^(temp|midi_songs).*";
			playlist_disable_highlight_delay = 0;
			message_delay_time = 2;
			browser_sort_mode = "type";
			seek_time = 5;
			volume_change_step = 5;
			default_place_to_search_in = "database";
			cyclic_scrolling = true;
			follow_now_playing_lyrics = true;
			fetch_lyrics_for_current_song_in_background = true;
			screen_switcher_mode = "previous";
			ask_before_clearing_playlists = true;
			regular_expressions = "extended";
			mouse_support = false;
			tag_editor_extended_numeration = true;
			search_engine_default_search_mode = 2;
			external_editor = "$EDITOR";
		};

		/*
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
		*/
	};
}
