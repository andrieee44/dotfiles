{ config, ... }:
{
  programs.mangohud =
    let
      mkConf = settings: config.programs.mangohud.settings // settings;
    in
    {
      enableSessionWide = true;

      settingsPerApplication = {
        wine-umvc3 = mkConf { fps_limit = 60; };
        supertux2 = mkConf { fps_limit = 60; };
      };

      settings = {
        arch = true;
        battery = true;
        battery_time = true;
        blacklist = "amtrucks";
        cpu_load_change = true;
        cpu_stats = true;
        cpu_temp = true;
        device_battery = "gamepad,mouse";
        display_server = true;
        exec_name = true;
        fps = true;
        fps_limit = 30;
        fps_sampling_period = 1000;
        frame_timing = false;
        frametime = true;
        gamemode = true;
        gpu_load_change = true;
        gpu_name = true;
        gpu_stats = true;
        gpu_temp = true;
        network = true;
        permit_upload = false;
        present_mode = true;
        ram = true;
        resolution = true;
        swap = true;
        text_outline = true;
        throttling_status = true;
        time = true;
        time_format = "%b %e %Y (%a) %l:%M %p";
        wine = true;
        winesync = true;
      };
    };
}
