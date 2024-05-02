{ config, colorscheme, ... }:
{
	services.mako = {
		backgroundColor = "#${colorscheme.palette.base03}";
		borderColor = "#${colorscheme.palette.base0C}";
		borderRadius = 5;
		borderSize = 5;
		defaultTimeout = 150000;
		font = config.gtk.font.name;
		format = "<b>%a - %s</b>\\n\\n%b";
		height = 150;
		layer = "overlay";
		margin = "20,20";
		progressColor = "#${colorscheme.palette.base0C}";
		textColor = "#${colorscheme.palette.base05}";

		extraConfig = ''
text-alignment=center

[urgency=low]
border-color=#${colorscheme.palette.base00}

[urgency=high]
border-color=#${colorscheme.palette.base08}
default-timeout=0'';
	};
}
