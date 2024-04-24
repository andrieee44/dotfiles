{ config, colorscheme, ... }:
{
	programs.mangohud = {
		enableSessionWide = true;

		settings = {
			alpha = 1;
			arch = true;
			background_alpha = 0.5;
			background_color = colorscheme.palette.base00;
			battery_icon = "󰁹";
			battery_time = true;
			battery = true;
			cellpadding_y = 0;
			cpu_color = colorscheme.palette.base0D;
			cpu_load_change = true;
			cpu_load_color = "${colorscheme.palette.base0B},${colorscheme.palette.base0A},${colorscheme.palette.base08}";
			cpu_stats = true;
			cpu_temp = true;
			device_battery = "gamepad,mouse";
			device_battery_icon = "󰂯";
			engine_color = colorscheme.palette.base08;
			exec_name = true;
			font_file_text = config.gtk.font.name;
			font_size = config.gtk.font.size;
			fps_color = "${colorscheme.palette.base08},${colorscheme.palette.base0A},${colorscheme.palette.base0B}";
			fps_color_change = true;
			fps_limit = 60;
			fps_sampling_period = 1000;
			fps = true;
			frametime = true;
			frame_timing = false;
			gamemode = true;
			gpu_color = colorscheme.palette.base0B;
			gpu_load_change = true;
			gpu_load_color = "${colorscheme.palette.base0B},${colorscheme.palette.base0A},${colorscheme.palette.base08}";
			gpu_name = true;
			gpu_stats = true;
			gpu_temp = true;
			height = 0;
			hud_compact = true;
			hud_no_margin = false;
			no_small_font = true;
			permit_upload = false;
			position = "middle-left";
			present_mode = true;
			ram_color = colorscheme.palette.base0E;
			ram = true;
			resolution = true;
			round_corners = 0;
			swap = true;
			table_columns = 3;
			text_color = colorscheme.palette.base05;
			text_outline_color = colorscheme.palette.base00;
			text_outline = true;
			throttling_status = true;
			time_format = "%b %e %Y (%a) %l:%M %p";
			time = true;
			width = 0;
			winesync = true;
			wine = true;
		};
	};
}
