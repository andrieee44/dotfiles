{
  programs.mangohud = {
    enableSessionWide = true;

    settings = {
      arch = true;
      battery = true;
      battery_icon = "󰁹";
      battery_time = true;
      cellpadding_y = 0;
      cpu_load_change = true;
      cpu_stats = true;
      cpu_temp = true;
      device_battery = "gamepad,mouse";
      device_battery_icon = "󰂯";
      display_server = true;
      engine_version = true;
      exec_name = true;
      fps = true;
      fps_color_change = true;
      fps_limit = 60;
      fps_sampling_period = 1000;
      frame_timing = false;
      frametime = true;
      gamemode = true;
      gpu_load_change = true;
      gpu_name = true;
      gpu_stats = true;
      gpu_temp = true;
      height = 0;
      hud_compact = true;
      hud_no_margin = false;
      no_small_font = true;
      permit_upload = false;
      position = "top-center";
      present_mode = true;
      ram = true;
      resolution = true;
      round_corners = 0;
      swap = true;
      table_columns = 3;
      text_outline = true;
      throttling_status = true;
      time = true;
      time_format = "%b %e %Y (%a) %l:%M %p";
      width = 0;
      wine = true;
      winesync = true;
    };
  };
}
