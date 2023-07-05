{ config, lib, osConfig, ... }:
{
	config.services.mpd = {
		dataDir = "${config.xdg.dataHome}/mpd";
		dbFile = "${config.services.mpd.dataDir}/tag_cache";
		playlistDirectory = "${config.services.mpd.dataDir}/playlists";
		musicDirectory = config.xdg.userDirs.music;

		extraConfig = ''
			log_level "verbose"
			restore_paused "yes"
			auto_update "yes"

			${lib.optionalString osConfig.services.pipewire.enable ''
				audio_output {
					type "pipewire"
					name "Pipewire Sound Server"
				}
			''}

			audio_output {
				type "fifo"
				name "Visualizer Feed"
				path "${config.services.mpd.dataDir}/visualizer.fifo"
				format "44100:16:2"
			}
		'';

		network = {
			listenAddress = "127.0.0.1";
			port = 6600;
			startWhenNeeded = true;
		};
	};
}
