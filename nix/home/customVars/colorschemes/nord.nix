{ config, pkgs, lib, ... }:
let
	colorscheme = config.customVars.colorschemes.nord;
	normal = colorscheme.normal;
	bright = colorscheme.bright;

	colorNums = config.customVars.colorNums;
	normalNums = colorNums.normal;
	brightNums = colorNums.bright;

	str = builtins.toString;
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
					background = bright.black;
				};

				search = {
					matches = {
						foreground = "CellBackground";
						background = normal.cyan;
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

				normal = normal;
				bright = bright;
			};

			fzf.colors = {
				fg = str normalNums.white;
				preview-fg = str normalNums.white;
				preview-bg = str normalNums.black;
				hl = str normalNums.blue;
				"fg+" = str normalNums.white;
				"bg+" = str normalNums.black;
				gutter = str normalNums.black;
				"hl+" = str normalNums.blue;
				query = str normalNums.white;
				disabled = str brightNums.white;
				info = str normalNums.cyan;
				separator = str normalNums.cyan;
				border = str normalNums.cyan;
				spinner = str normalNums.cyan;
				label = str normalNums.cyan;
				prompt = str normalNums.cyan;
				pointer = str normalNums.cyan;
				marker = str normalNums.cyan;
				header = str normalNums.cyan;
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

							local function customNord()
								local hl = api.nvim_set_hl
								local comment = {
									ctermfg = 'blue',
									fg = '${normal.blue}',
									italic = true,
								}

								hl(0, 'Visual', {
									ctermfg = 'darkgray',
									ctermbg = 'white',
									bg = '${bright.black}',
								})

								hl(0, 'LineNr', {
									ctermfg = 'blue',
									fg = '${normal.blue}',
								})

								hl(0, '@comment', comment)

								hl(0, 'Comment', comment)

								local error = {
									ctermfg = 'red',
									fg = '${normal.red}',
									bold = true,
								}

								local warn = {
									ctermfg = 'yellow',
									fg = '${normal.yellow}',
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
								callback = customNord,
								group = nordAugroup,

								pattern = {
									'nord',
								},
							})

							g.nord_disable_background = true
							require('nord').set()

							g.customLightline = function()
								local function copyTable(table)
									local tmp = {}

									if type(table) == "table" then
										for k, v in pairs(table) do
											tmp[k] = copyTable(v)
										end
									else
										tmp = table
									end

									return tmp
								end

								local tmp = g['lightline#colorscheme#nord#palette']

								tmp.normal.left = {
									{ '${normal.black}', '${normal.cyan}', ${str normalNums.black}, ${str normalNums.cyan}, 'bold', },
									{ '${normal.white}', '${normal.black}', ${str normalNums.white}, ${str normalNums.black}, },
									{ '${normal.black}', '${normal.cyan}', ${str normalNums.black}, ${str normalNums.cyan}, },
								}

								tmp.visual.left = copyTable(tmp.normal.left)
								tmp.visual.left[1][2] = '${normal.green}'
								tmp.visual.left[1][4] = ${str normalNums.green}

								tmp.insert.left = copyTable(tmp.normal.left)
								tmp.insert.left[1][2] = '${bright.white}'
								tmp.insert.left[1][4] = ${str normalNums.white}

								tmp.replace.left = copyTable(tmp.normal.left)
								tmp.replace.left[1][2] = '${normal.yellow}'
								tmp.replace.left[1][4] = ${str normalNums.yellow}

								tmp.normal.right = {
									{ '${normal.white}', '${bright.black}', ${str normalNums.white}, ${str brightNums.black}, },
								}

								tmp.normal.error[1] = { '${normal.white}', '${normal.red}', ${str normalNums.white}, ${str normalNums.red}, 'bold' }
								tmp.normal.warning[1] = { '${normal.black}', '${normal.yellow}', ${str normalNums.black}, ${str normalNums.yellow}, 'bold' }

								tmp.normal.middle = {{ '${normal.white}', '${normal.black}', ${str normalNums.white}, ${str brightNums.black}, },}
								tmp.visual.middle = copyTable(tmp.normal.middle)
								tmp.insert.middle = copyTable(tmp.normal.middle)
								tmp.replace.middle = copyTable(tmp.normal.middle)

								vim.g['lightline#colorscheme#nord#palette'] = tmp
							end
EOF
					'';
				}
			];

			swaylock.settings = let
				ringColor = normal.black;
				keyColor = normal.cyan;
				warnColor = normal.yellow;
				verColor = normal.green;
				errorColor = normal.red;
			in {
				image = "${./../wallpapers/${config.customVars.colorscheme}/lock.png}";
				bs-hl-color = warnColor;
				text-color = keyColor;
				text-clear-color = warnColor;
				text-ver-color = verColor;
				text-wrong-color = errorColor;
				inside-color = ringColor;
				inside-clear-color = ringColor;
				inside-ver-color = ringColor;
				inside-wrong-color = ringColor;
				key-hl-color = keyColor;
				ring-color = ringColor;
				ring-clear-color = warnColor;
				ring-ver-color = verColor;
				ring-wrong-color = errorColor;
				line-color = keyColor;
				line-clear-color = keyColor;
				line-ver-color = keyColor;
				line-wrong-color = keyColor;
				separator-color = "#00000000";
			};

			tmux = {
				extraConfig = let
					nerdFont = "#{&&:#{!=:${"\${XDG_SESSION_TYPE}"},tty}, true}";
				in ''
					set -Fg status-left "#[fg=black,bg=cyan,bold] ##S #{?${nerdFont},#[fg=cyan#,bg=black#,nobold],}"
					set -Fg status-right "#{?${nerdFont},#[fg=brightblack#,bg=black]#[fg=white#,bg=brightblack] ${config.customVars.dateFmt} #[fg=cyan]#[fg=black#,bg=cyan#,bold] #{user}@##H ,#[fg=white#,bg=brightblack] ${config.customVars.dateFmt} #[fg=black#,bg=cyan#,bold] #{user}@##H }"

					set -Fg window-status-format "#{?${nerdFont},#[fg=black#,bg=brightblack]#[fg=white] ##I  ##W ##F #[fg=brightblack#,bg=black], #[fg=white#,bg=brightblack]##I ##W ##F}"
					set -Fg window-status-current-format "#{?${nerdFont},#[fg=black#,bg=cyan] ##I  ##W ##F #[fg=cyan#,bg=black], #[fg=black#,bg=cyan]##I ##W ##F}"
					set -g window-status-separator ""

					set -g pane-border-style fg=black,dim,bold
					set -g pane-active-border-style fg=cyan,bold
					set -g popup-border-style fg=cyan,bold
				'';

				plugins = with pkgs; [
					{
						plugin = tmuxPlugins.nord;
					}
				];
			};

			zsh.initExtra = "PS1=\"%B%{$fg[white]%}[%{$fg[cyan]%}%n@%M %{$fg[blue]%}%~%{$fg[yellow]%}%(?.. %?)%{$fg[white]%}]$%b%{$reset_color%} \"";
		};

		xdg.configFile.dircolors.text = ''
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

		wayland.windowManager.sway.config = {
			colors = {
				focused = {
					border = normal.red;
					background = normal.red;
					text = normal.red;
					indicator = normal.cyan;
					childBorder = normal.cyan;
				};

				focusedInactive = {
					border = normal.green;
					background = normal.green;
					text = normal.green;
					indicator = normal.cyan;
					childBorder = normal.cyan;
				};

				unfocused = {
					border = normal.blue;
					background = normal.blue;
					text = normal.blue;
					indicator = bright.black;
					childBorder = bright.black;
				};

				urgent = {
					border = normal.cyan;
					background = normal.cyan;
					text = normal.cyan;
					indicator = normal.red;
					childBorder = normal.red;
				};

				placeholder = {
					border = normal.yellow;
					background = normal.yellow;
					text = normal.yellow;
					indicator = normal.yellow;
					childBorder = normal.yellow;
				};
			};

			output."*".bg = "${./../wallpapers/${config.customVars.colorscheme}/home.png} fill";
		};
	};
}
