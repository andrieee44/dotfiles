{ config, ... }:
{
	config.services.dunst = {
		iconTheme = config.gtk.iconTheme;

		settings = let
			bg = "#4c566a";
			fg = "#eceff4";
			hl = "#a3be8c";
		in {
			global = {
				monitor = 0;
				follow = "keyboard";
				width = 300;
				height = 500;
				origin = "top-right";
				offset = "10x55";
				scale = 0;
				notification_limit = 8;
				progress_bar = true;
				progress_bar_height = 10;
				progress_bar_frame_width = 1;
				progress_bar_min_width = 150;
				progress_bar_max_width = 300;
				indicate_hidden = true;
				separator_height = 3;
				padding = 5;
				horizontal_padding = 5;
				text_icon_padding = 5;
				frame_width = 3;
				frame_color = "#81a1c1";
				gap_size = 0;
				separator_color = "frame";
				sort = true;
				idle_threshold = 30;
				font = config.gtk.font.name;
				line_height = 0;
				markup = "full";
				format = ''<b>%s</b>\n%b\n%p'';
				alignment = "center";
				vertical_alignment = "center";
				show_age_threshold = 11;
				ellipsize = "middle";
				ignore_newline = false;
				stack_duplicates = true;
				hide_duplicate_count = false;
				show_indicators = false;
				icon_position = "left";
				min_icon_size = 32;
				max_icon_size = 128;
				sticky_history = true;
				history_length = 20;
				always_run_script = true;
				title = "Dunst";
				class = "Dunst";
				corner_radius = 10;
				ignore_dbusclose = false;
				layer = "overlay";
				force_xwayland = false;
				mouse_left_click = "none";
				mouse_middle_click = "none";
				mouse_right_click = "none";
			};

			urgency_low = {
				background = bg;
				foreground = fg;
				highlight = hl;
				timeout = 10;
			};

			urgency_normal = {
				background = bg;
				foreground = fg;
				highlight = hl;
				timeout = 10;
			};

			urgency_critical = {
				background = bg;
				foreground = fg;
				highlight = hl;
				frame_color = "#bf616a";
				timeout = 0;
			};

			brightness = {
				summary = "Brightness";
				set_stack_tag = "synchronous";
				timeout = 3;
			};

			volume = {
				summary = "Volume";
				set_stack_tag = "synchronous";
				timeout = 3;
			};
		};
	};
}
