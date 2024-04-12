{ config, colorscheme, ... }:
{
	programs.imv.settings = {
		options = {
			overlay = true;
			overlay_font = "${config.gtk.font.name}:${builtins.toString config.gtk.font.size}";
			overlay_position_bottom = true;

			overlay_text_color = colorscheme.palette.base05;
			overlay_background_color = colorscheme.palette.base00;
			background = colorscheme.palette.base03;
		};

		binds = {
			"<Shift+H>" = "prev";
			"<Shift+J>" = "zoom -5%";
			"<Shift+K>" = "zoom 5%";
			"<Shift+L>" = "next";
		};
	};
}
