{ config, ... }:
{
	config.programs.imv.settings = {
		options = {
			overlay = true;
			overlay_font = "${config.gtk.font.name}:${builtins.toString config.gtk.font.size}";
			overlay_position_bottom = true;
		};

		binds = {
			"<Shift+H>" = "prev";
			"<Shift+J>" = "zoom -5%";
			"<Shift+K>" = "zoom 5%";
			"<Shift+L>" = "next";
		};
	};
}
