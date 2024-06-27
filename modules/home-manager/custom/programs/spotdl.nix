{ config, ... }:
{
	custom.programs.spotdl.settings = {
		lyrics_providers = [
			"genius"
			"azlyrics"
			"musixmatch"
		];

		add_unavailable = false;
		album_type = null;
		allowed_origins = null;
		archive = null;
		audio_providers = [ "youtube-music" ];
		auth_token = null;
		bitrate = null;
		cache_path = "${config.home.homeDirectory}/.spotdl/cache";
		client_id = "5f573c9620494bae87890c0f08a60293";
		client_secret = "212476d9b0f3472eaa762d90b19b0ba8";
		cookie_file = null;
		fetch_albums = false;
		ffmpeg_args = null;
		ffmpeg = "ffmpeg";
		filter_results = true;
		force_update_metadata = false;
		format = "opus";
		generate_lrc = false;
		headless = false;
		host = "localhost";
		id3_separator = "/";
		keep_alive = false;
		keep_sessions = false;
		load_config = true;
		log_level = "INFO";
		m3u = null;
		max_retries = 3;
		no_cache = false;
		only_verified_results = false;
		output = "{album-artist}.{album}.{track-number}.{title}.{output-ext}";
		overwrite = "skip";
		playlist_numbering = false;
		port = 8800;
		preload = false;
		print_errors = false;
		restrict = null;
		save_file = null;
		scan_for_songs = false;
		search_query = null;
		simple_tui = false;
		skip_album_art = false;
		sponsor_block = false;
		threads = 4;
		user_auth = false;
		web_use_output_dir = false;
		ytm_data = false;
	};
}
