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

			ram = true;

			fps = true;
			fps_color_change = true;
			frametime = true;
			frame_timing = false;

			throttling_status = true;
			wine = true;
			gamemode = true;

			text_outline = true;
			no_small_font = true;
		};
	};
}
