{ ... }:
{
	services.mako = {
		borderRadius = 5;
		borderSize = 5;
		defaultTimeout = 150000;
		format = "<b>%a - %s</b>\\n\\n%b";
		height = 150;
		layer = "overlay";
		margin = "20,20";

		extraConfig = ''
text-alignment=center

[urgency=high]
default-timeout=0'';
	};
}
