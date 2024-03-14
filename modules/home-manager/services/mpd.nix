{ config, ... }:
{
	services.mpd = {
		dataDir = "${config.xdg.dataHome}/mpd";
		dbFile = "${config.services.mpd.dataDir}/tag_cache";
		playlistDirectory = "${config.services.mpd.dataDir}/playlists";
		musicDirectory = config.xdg.userDirs.music;
		network.startWhenNeeded = true;

		extraConfig = ''
			log_level "verbose"
			restore_paused "yes"
			auto_update "yes"

			audio_output {
				type "pipewire"
				name "Pipewire Sound Server"
			}

			audio_output {
				type "fifo"
				name "Visualizer Feed"
				path "${config.services.mpd.dataDir}/visualizer.fifo"
				format "44100:16:2"
			}
		'';
	};
}
