{ colorscheme, ... }:
{
	programs.hyprlock.settings = ''
		general {
			grace = 1
		}

		background {
			path = ${./../custom/wallpapers/${colorscheme.slug}/lock}
		}
	'';
}
