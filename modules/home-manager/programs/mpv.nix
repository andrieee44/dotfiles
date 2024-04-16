{ pkgs, colorscheme, ... }:
{
	programs.mpv = {
		bindings = {
			h = "seek -5";
			j = "seek -60";
			k = "seek 60";
			l = "seek 5";
			H = "add volume -5";
			J = "frame-back-step";
			K = "frame-step";
			L = "add volume 5";
			u = ''cycle-values loop-file "inf" "no"'';
		};

		scripts = with pkgs.mpvScripts; [
			uosc
			thumbfast
		];

		scriptOpts = {
			uosc.color = "foreground=${colorscheme.palette.base05},foreground_text=${colorscheme.palette.base00},background=${colorscheme.palette.base00},background_text=${colorscheme.palette.base05},curtain=${colorscheme.palette.base03},success=${colorscheme.palette.base0B},error=${colorscheme.palette.base08}";
			thumbfast.network = true;
		};

		config = {
			osd-bar = false;
			border = false;
			video-sync = "display-resample";
		};
	};
}
