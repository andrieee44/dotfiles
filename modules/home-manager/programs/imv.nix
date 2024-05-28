{ config, ... }:
{
	programs.imv.settings = {
		options = let
			colors = config.lib.stylix.colors.withHashtag;
		in {
			overlay = true;
			overlay_font = "${config.gtk.font.name}:${builtins.toString config.gtk.font.size}";
			overlay_position_bottom = true;
			overlay_text_color = colors.base05;
			overlay_background_color = colors.base02;
			background = colors.base01;
		};

		binds = {
			"<Shift+H>" = "prev";
			"<Shift+J>" = "zoom -5%";
			"<Shift+K>" = "zoom 5%";
			"<Shift+L>" = "next";
		};
	};
}
