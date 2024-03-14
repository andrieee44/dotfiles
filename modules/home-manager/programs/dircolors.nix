{ ... }:
{
	programs.dircolors = {
		settings.COLOR = "tty";

		extraConfig = ''
			TERM alacritty
			TERM alacritty-direct
			TERM ansi
			TERM *color*
			TERM con[0-9]*x[0-9]*
			TERM cons25
			TERM console
			TERM cygwin
			TERM dtterm
			TERM dvtm
			TERM dvtm-256color
			TERM Eterm
			TERM eterm-color
			TERM fbterm
			TERM gnome
			TERM gnome-256color
			TERM hurd
			TERM jfbterm
			TERM konsole
			TERM konsole-256color
			TERM kterm
			TERM linux
			TERM linux-c
			TERM mlterm
			TERM putty
			TERM putty-256color
			TERM rxvt*
			TERM rxvt-unicode
			TERM rxvt-256color
			TERM rxvt-unicode256
			TERM screen*
			TERM screen-256color
			TERM st
			TERM st-256color
			TERM terminator
			TERM tmux*
			TERM tmux-256color
			TERM vt100
			TERM xterm*
			TERM xterm-color
			TERM xterm-88color
			TERM xterm-256color
			TERM xterm-kitty
		'';
	};
}
