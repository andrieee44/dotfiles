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
