{
	programs.zathura = {
		options = {
			sandbox = "normal";
			recolor = true;
			statusbar-h-padding = 0;
			statusbar-v-padding = 0;
			page-padding = 1;
			selection-clipboard = "clipboard";
			render-loading = "true";
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
