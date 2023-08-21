{ config, pkgs, lib, ... }:
let
	colorscheme = config.customVars.colorschemes.nord;
in {
	config = {
		programs = lib.mkIf (config.customVars.colorscheme == "nord") {
			alacritty.settings.colors = {
				primary = {
					background = "#2e3440";
					foreground = "#d8dee9";
					dim_foreground = "#a5abb6";
				};

				cursor = {
					text = "#2e3440";
					cursor = "#d8dee9";
				};

				vi_mode_cursor = {
					text = "#2e3440";
					cursor = "#d8dee9";
				};

				selection = {
					text = "CellForeground";
					background = "#4c566a";
				};

				search = {
					matches = {
						foreground = "CellBackground";
						background = "#88c0d0";
					};
				};

				footer = {
					bar = {
						background = "#434c5e";
						foreground = "#d8dee9";
					};
				};

				dim = {
					black = "#373e4d";
					red = "#94545d";
					green = "#809575";
					yellow = "#b29e75";
					blue = "#68809a";
					magenta = "#8c738c";
					cyan = "#6d96a5";
					white = "#aeb3bb";
				};

				normal = colorscheme.normal;
				bright = colorscheme.bright;
			};

			fzf.colors = {
				fg = "7";
				preview-fg = "7";
				preview-bg = "0";
				hl = "4";
				"fg+" = "7";
				"bg+" = "0";
				gutter = "0";
				"hl+" = "4";
				query = "7";
				disabled = "8";
				info = "6";
				separator = "6";
				border = "6";
				spinner = "6";
				label = "6";
				prompt = "6";
				pointer = "6";
				marker = "6";
				header = "6";
			};

			neovim.plugins = [
				{
					plugin = pkgs.vimPlugins.nord-nvim;

					config = ''
						lua <<EOF
							local g = vim.g
							local api = vim.api
							local mkAugroup = api.nvim_create_augroup
							local mkAutocmd = api.nvim_create_autocmd

							local function nordSettings()
								local hl = api.nvim_set_hl
								local comment = {
									ctermfg = 'blue',
									fg = '#81a1c1',
									italic = true,
								}

								hl(0, 'Visual', {
									ctermfg = 'black',
									ctermbg = 'white',
									bg = '#4c566a',
								})

								hl(0, 'LineNr', {
									ctermfg = 'blue',
									fg = '#81a1c1',
								})

								hl(0, '@comment', comment)

								hl(0, 'Comment', comment)

								local error = {
									ctermfg = 'red',
									fg = '#bf616a',
									bold = true,
								}

								local warn = {
									ctermfg = 'yellow',
									fg = '#ebcb8b',
									bold = true,
								}

								hl(0, 'DiagnosticVirtualTextError', error)
								hl(0, 'DiagnosticSignError', error)
								hl(0, 'DiagnosticFloatingError', error)

								hl(0, 'DiagnosticVirtualTextWarn', warn)
								hl(0, 'DiagnosticSignWarn', warn)
								hl(0, 'DiagnosticFloatingWarn', warn)
							end

							local nordAugroup = mkAugroup('nordAugroup', {})

							mkAutocmd('ColorScheme', {
								callback = nordSettings,
								group = nordAugroup,

								pattern = {
									'nord',
								},
							})

							g.nord_disable_background = true
							require('nord').set()
EOF
					'';
				}
			];
		};

		xdg.configFile.dircolors = {
			enable = true;
			target = "dircolors/dircolors";

			text = ''
				COLOR tty

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

				#+-----------------+
				#+ Global Defaults +
				#+-----------------+
				NORMAL 00
				RESET 0

				FILE 00
				DIR 01;34
				LINK 36
				MULTIHARDLINK 04;36

				FIFO 04;01;36
				SOCK 04;33
				DOOR 04;01;36
				BLK 01;33
				CHR 33

				ORPHAN 31
				MISSING 01;37;41

				EXEC 01;36

				SETUID 01;04;37
				SETGID 01;04;37
				CAPABILITY 01;37

				STICKY_OTHER_WRITABLE 01;37;44
				OTHER_WRITABLE 01;04;34
				STICKY 04;37;44

				#+-------------------+
				#+ Extension Pattern +
				#+-------------------+
				#+--- Archives ---+
				.7z 01;32
				.ace 01;32
				.alz 01;32
				.arc 01;32
				.arj 01;32
				.bz 01;32
				.bz2 01;32
				.cab 01;32
				.cpio 01;32
				.deb 01;32
				.dz 01;32
				.ear 01;32
				.gz 01;32
				.jar 01;32
				.lha 01;32
				.lrz 01;32
				.lz 01;32
				.lz4 01;32
				.lzh 01;32
				.lzma 01;32
				.lzo 01;32
				.rar 01;32
				.rpm 01;32
				.rz 01;32
				.sar 01;32
				.t7z 01;32
				.tar 01;32
				.taz 01;32
				.tbz 01;32
				.tbz2 01;32
				.tgz 01;32
				.tlz 01;32
				.txz 01;32
				.tz 01;32
				.tzo 01;32
				.tzst 01;32
				.war 01;32
				.xz 01;32
				.z 01;32
				.Z 01;32
				.zip 01;32
				.zoo 01;32
				.zst 01;32

				#+--- Audio ---+
				.aac 32
				.au 32
				.flac 32
				.m4a 32
				.mid 32
				.midi 32
				.mka 32
				.mp3 32
				.mpa 32
				.mpeg 32
				.mpg 32
				.ogg 32
				.opus 32
				.ra 32
				.wav 32

				#+--- Customs ---+
				.3des 01;35
				.aes 01;35
				.gpg 01;35
				.pgp 01;35

				#+--- Documents ---+
				.doc 32
				.docx 32
				.dot 32
				.odg 32
				.odp 32
				.ods 32
				.odt 32
				.otg 32
				.otp 32
				.ots 32
				.ott 32
				.pdf 32
				.ppt 32
				.pptx 32
				.xls 32
				.xlsx 32

				#+--- Executables ---+
				.app 01;36
				.bat 01;36
				.btm 01;36
				.cmd 01;36
				.com 01;36
				.exe 01;36
				.reg 01;36

				#+--- Ignores ---+
				*~ 02;37
				.bak 02;37
				.BAK 02;37
				.log 02;37
				.log 02;37
				.old 02;37
				.OLD 02;37
				.orig 02;37
				.ORIG 02;37
				.swo 02;37
				.swp 02;37

				#+--- Images ---+
				.bmp 32
				.cgm 32
				.dl 32
				.dvi 32
				.emf 32
				.eps 32
				.gif 32
				.jpeg 32
				.jpg 32
				.JPG 32
				.mng 32
				.pbm 32
				.pcx 32
				.pgm 32
				.png 32
				.PNG 32
				.ppm 32
				.pps 32
				.ppsx 32
				.ps 32
				.svg 32
				.svgz 32
				.tga 32
				.tif 32
				.tiff 32
				.xbm 32
				.xcf 32
				.xpm 32
				.xwd 32
				.xwd 32
				.yuv 32

				#+--- Video ---+
				.anx 32
				.asf 32
				.avi 32
				.axv 32
				.flc 32
				.fli 32
				.flv 32
				.gl 32
				.m2v 32
				.m4v 32
				.mkv 32
				.mov 32
				.MOV 32
				.mp4 32
				.mpeg 32
				.mpg 32
				.nuv 32
				.ogm 32
				.ogv 32
				.ogx 32
				.qt 32
				.rm 32
				.rmvb 32
				.swf 32
				.vob 32
				.webm 32
				.wmv 32
			'';
		};
	};
}
