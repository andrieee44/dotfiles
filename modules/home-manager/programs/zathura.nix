{ colorscheme, ... }:
{
	programs.zathura = {
		options = {
			database = "sqlite";
			page-padding = 1;
			recolor = true;
			render-loading = "true";
			sandbox = "normal";
			selection-clipboard = "clipboard";
			statusbar-h-padding = 0;
			statusbar-v-padding = 0;

			notification-error-bg = "#${colorscheme.palette.base00}";
			notification-error-fg = "#${colorscheme.palette.base08}";
			notification-warning-bg = "#${colorscheme.palette.base00}";
			notification-warning-fg = "#${colorscheme.palette.base0A}";
			notification-bg = "#${colorscheme.palette.base00}";
			notification-fg = "#${colorscheme.palette.base05}";

			completion-bg = "#${colorscheme.palette.base00}";
			completion-fg = "#${colorscheme.palette.base05}";
			completion-group-bg = "#${colorscheme.palette.base00}";
			completion-group-fg = "#${colorscheme.palette.base05}";
			completion-highlight-bg = "#${colorscheme.palette.base0D}";
			completion-highlight-fg = "#${colorscheme.palette.base00}";

			index-bg = "#${colorscheme.palette.base00}";
			index-fg = "#${colorscheme.palette.base0C}";
			index-active-bg = "#${colorscheme.palette.base0C}";
			index-active-fg = "#${colorscheme.palette.base00}";

			inputbar-bg = "#${colorscheme.palette.base00}";
			inputbar-fg = "#${colorscheme.palette.base05}";

			statusbar-bg = "#${colorscheme.palette.base00}";
			statusbar-fg = "#${colorscheme.palette.base05}";

			highlight-color = "#${colorscheme.palette.base0A}";
			highlight-active-color = "#${colorscheme.palette.base08}";

			default-bg = "#${colorscheme.palette.base03}";
			default-fg = "#${colorscheme.palette.base05}";
			render-loading-bg = "#${colorscheme.palette.base00}";
			render-loading-fg = "#${colorscheme.palette.base03}";

			recolor-lightcolor = "#${colorscheme.palette.base00}";
			recolor-darkcolor = "#${colorscheme.palette.base05}";
		};

		mappings = {
			u = "scroll half-up";
			d = "scroll half-down";
			D = "toggle_page_mode";
			r = "reload";
			R = "rotate";
			H = "scroll full-up";
			K = "zoom in";
			J = "zoom out";
			L = "scroll full-down";
			i = "recolor";
			g = "goto top";
		};
	};
}
