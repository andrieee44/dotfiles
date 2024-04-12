{ config, colorscheme, ... }:
{
	programs.mangohud = {
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
			time_format = "%b %e %Y (%a) %l:%M %p";
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
			position = "middle-left";
			font_size = config.gtk.font.size * 1.5;
			background_alpha = 0.3;
			alpha = 0.9;
			cpu_load_color = "${colorscheme.palette.base0B},${colorscheme.palette.base0A},${colorscheme.palette.base08}";
			gpu_load_color = "${colorscheme.palette.base0B},${colorscheme.palette.base0A},${colorscheme.palette.base08}";
			fps_color = "${colorscheme.palette.base08},${colorscheme.palette.base0A},${colorscheme.palette.base0B}";
			text_color = colorscheme.palette.base05;
			gpu_color = colorscheme.palette.base0B;
			cpu_color = colorscheme.palette.base0D;
			ram_color = colorscheme.palette.base0E;
			engine_color = colorscheme.palette.base08;
			background_color = colorscheme.palette.base00;
		};
	};
}
