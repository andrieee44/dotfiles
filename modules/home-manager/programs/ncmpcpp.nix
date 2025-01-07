{ config, pkgs, ... }:
{
  programs.ncmpcpp = {
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };

    settings =
      let
        mpd = config.services.mpd;
      in
      {
        ncmpcpp_directory = "${config.xdg.configHome}/ncmpcpp";
        lyrics_directory = "${mpd.dataDir}/lyrics";
        mpd_host = mpd.network.listenAddress;
        mpd_port = mpd.network.port;
        mpd_connection_timeout = 5;
        mpd_crossfade_time = 5;
        random_exclude_pattern = "^(temp|midi_songs).*";
        playlist_disable_highlight_delay = 0;
        message_delay_time = 2;
        browser_sort_mode = "name";
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
        external_editor = config.home.sessionVariables.EDITOR;
        media_library_primary_tag = "album_artist";
      };

    bindings =
      let
        mkBinding =
          key: commands:
          builtins.map (command: {
            key = key;
            command = command;
          }) commands;
      in
      (mkBinding "h" [ "previous_column" ])
      ++ (mkBinding "j" [ "scroll_down" ])
      ++ (mkBinding "k" [ "scroll_up" ])
      ++ (mkBinding "u" [ "page_up" ])
      ++ (mkBinding "d" [ "page_down" ])
      ++ (mkBinding "g" [ "move_home" ])
      ++ (mkBinding "G" [ "move_end" ])
      ++ (mkBinding "n" [ "next_found_item" ])
      ++ (mkBinding "N" [ "previous_found_item" ])
      ++ (mkBinding "l" [
        "next_column"
        "run_action"
        "play_item"
      ]);

  };
}
