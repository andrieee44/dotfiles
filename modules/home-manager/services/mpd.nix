{ config, ... }:
{
  services.mpd =
    let
      mpd = config.services.mpd;
    in
    {
      dataDir = "${config.xdg.dataHome}/mpd";
      dbFile = "${mpd.dataDir}/tag_cache";
      playlistDirectory = "${mpd.dataDir}/playlists";
      network.startWhenNeeded = true;

      extraConfig = ''
        	log_file "${mpd.dataDir}/log"
        	pid_file "${mpd.dataDir}/pid"
        	restore_paused "yes"
        	log_level "verbose"
        	auto_update "yes"

        	audio_output {
        		type "pipewire"
        		name "Pipewire Sound Server"
        	}
      '';
    };
}
