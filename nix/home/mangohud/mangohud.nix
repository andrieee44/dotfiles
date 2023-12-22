{ config, ... }:
{
	config.programs.mangohud = {
		enableSessionWide = true;

		settings = {
			fps_limit = 60;

			cpu_stats = true;
			cpu_temp = true;
			cpu_load_change = true;

			gpu_stats = true;
			gpu_temp = true;
			gpu_load_change = true;
			throttling_status = true;

			ram = true;
			swap = true;

			fps = true;
			fps_color_change = true;
			frametime = true;
			frame_timing = false;

			resolution = true;

			time = true;
			time_format = config.customVars.dateFmt;

			battery = true;
			battery_time = true;
			device_battery = "gamepad";

			wine = true;
			gamemode = true;
			exec_name = true;

			text_outline = true;
			no_small_font = true;

			width = 0;
			height = 0;
			table_columns = 3;
			cellpadding_y = 0;
			round_corners = 0;
			hud_no_margin = false;
			hud_compact = true;
			position = "top-center";
		};
	};
}
