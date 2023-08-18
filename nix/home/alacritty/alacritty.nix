{ config, ... }:
{
	config.programs.alacritty = {
		settings = {
			env = {
				TERM = "alacritty";
			};

			window = {
				opacity = 0.9;
				title = "Alacritty";
				dynamic_title = true;

				class = {
					instance = "Alacritty";
					general = "Alacritty";
				};
			};

			scrolling = {
				history = 0;
			};

			font = {
				normal = {
					family = "monospace";
					style = "Regular";
				};

				bold = {
					family = "monospace";
					style = "Bold";
				};

				italic = {
					family = "monospace";
					style = "Italic";
				};

				bold_italic = {
					family = "monospace";
					style = "Bold Italic";
				};

				size = config.gtk.font.size + 2;
				builtin_box_drawing = true;
			};

			draw_bold_text_with_bright_colors = true;
			live_config_reload = true;
		};
	};
}
