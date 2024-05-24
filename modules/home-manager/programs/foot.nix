{ config, colorscheme, ... }:
{
	programs.foot = {
		server.enable = true;

		settings = {
			colors = {
				foreground = colorscheme.palette.base05;
				background = colorscheme.palette.base00;
				regular0 = colorscheme.palette.base00;
				regular1 = colorscheme.palette.base08;
				regular2 = colorscheme.palette.base0B;
				regular3 = colorscheme.palette.base0A;
				regular4 = colorscheme.palette.base0D;
				regular5 = colorscheme.palette.base0E;
				regular6 = colorscheme.palette.base0C;
				regular7 = colorscheme.palette.base05;
				bright0 = colorscheme.palette.base03;
				bright1 = colorscheme.palette.base08;
				bright2 = colorscheme.palette.base0B;
				bright3 = colorscheme.palette.base0A;
				bright4 = colorscheme.palette.base0D;
				bright5 = colorscheme.palette.base0E;
				bright6 = colorscheme.palette.base0C;
				bright7 = colorscheme.palette.base07;
				"16" = colorscheme.palette.base09;
				"17" = colorscheme.palette.base0F;
				"18" = colorscheme.palette.base01;
				"19" = colorscheme.palette.base02;
				"20" = colorscheme.palette.base04;
				"21" = colorscheme.palette.base06;
			};
		};
	};
}
