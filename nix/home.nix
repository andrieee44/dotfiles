{ config, pkgs, lib, osConfig, ... }:
{
	imports = [
		./customVars.nix
	] ++ import ./importPath.nix lib ./home;

	config = {
		wayland.windowManager.sway.enable = config.customVars.gui;
		nixpkgs.config.allowUnfree = true;
		fonts.fontconfig.enable = true;

		home = {
			username = config.customVars.user;
			homeDirectory = "/home/${config.home.username}";
			stateVersion = "22.11";
			enableNixpkgsReleaseCheck = true;

			packages = lib.mkMerge [
				(with pkgs; [
					(lib.mkIf config.services.mpd.enable mpc-cli)
					moar
					bc
					neofetch
					powertop
					xdg-user-dirs
					hugo
				])

				(with config.customVars.fzfscripts; [
					pathmenu
					sysmenu
				])

				(with config.customVars.statusbar; [
					volume
					brightness
					battery
					cpu
					date
					ram
				])

				(lib.optionals config.customVars.gui (with pkgs; [
					lutris
					glxinfo
					grim
					wl-clipboard
					gamemode
				]))
			];

			shellAliases = let
				unixUtils = config.customVars.unixUtils;
			in {
				cp = "${unixUtils}/cp -iv";
				mv = "${unixUtils}/mv -iv";
				rm = "${unixUtils}/rm -iv";
				mkdir = "${unixUtils}/mkdir -pv";
				rmdir = "${unixUtils}/rmdir -p";
				ip = "${pkgs.iproute2}/bin/ip -color=auto";
				df = "${unixUtils}/df -Pha";
				bc = "${pkgs.bc}/bin/bc ${config.home.homeDirectory}/${config.xdg.configFile.bcrc.target} -ql";
				ls = "LC_ALL=C ${pkgs.coreutils}/bin/ls -AFhl --time=use --time-style='+%b %e %Y (%a) %l:%M %p' --color=auto --group-directories-first";
				grep = "${pkgs.gnugrep}/bin/grep --color=auto";
				diff = "${pkgs.diffutils}/bin/diff --color=auto";
				nix-shell = "HISTFILE=${config.xdg.dataHome}/nix-shell.history ${pkgs.cached-nix-shell}/bin/cached-nix-shell";
			};

			sessionVariables = {
				LESSHISTFILE = "-";
				NPM_CONFIG_USERCONFIG = "${config.home.homeDirectory}/${config.xdg.configFile.npmrc.target}";
				W3M_DIR = "${config.xdg.dataHome}/w3m";
				MOAR = "--style ${config.customVars.colorscheme}";

				PAGER = lib.optionalString (builtins.any (pkg:
					pkg == pkgs.moar
				) config.home.packages) "${pkgs.moar}/bin/moar";
			};

			language = let
				locale = "fil_PH";
				defaultLocale = osConfig.i18n.defaultLocale;
			in {
				address = locale;
				base = defaultLocale;
				collate = defaultLocale;
				measurement = locale;
				messages = defaultLocale;
				name = locale;
				numeric = locale;
				paper = locale;
				telephone = locale;
				time = locale;
			};
		};

		xdg = let
			baseDir = "${config.home.homeDirectory}/xdg";
		in {
			enable = true;
			mime.enable = true;
			mimeApps.enable = true;
			configHome = "${config.home.homeDirectory}/.config";
			cacheHome = "${baseDir}/cache";
			dataHome = "${baseDir}/share";
			stateHome = "${baseDir}/state";

			userDirs = 	{
				enable = true;
				createDirectories = true;
				desktop = config.home.homeDirectory;
				documents = "${baseDir}/documents";
				download = "${baseDir}/downloads";
				music = "${baseDir}/music";
				pictures = "${baseDir}/pictures";
				publicShare = "${baseDir}/public";
				templates = "${baseDir}/templates";
				videos = "${baseDir}/videos";
			};
		};

		gtk = {
			enable = config.customVars.gui;
			gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

			cursorTheme = let
				colorschemes = {
					nord = {
						package = pkgs.nordzy-cursor-theme;
						name = "Nordzy-cursors";
						size = 16;
					};
				};
			in colorschemes.${config.customVars.colorscheme};

			iconTheme = let
				colorschemes = {
					nord = {
						package = pkgs.nordzy-icon-theme;
						name = "Nordzy-dark";
					};
				};
			in colorschemes.${config.customVars.colorscheme};

			font = {
				package = pkgs.nerdfonts.override {
					fonts = [
						"SourceCodePro"
					];
				};

				name = "Sauce Code Pro Nerd Font Mono";
				size = 12;
			};

			theme = let
				colorschemes = {
					nord = {
						package = pkgs.nordic;
						name = "Nordic";
					};
				};
			in colorschemes.${config.customVars.colorscheme};
		};

		qt = {
			enable = config.customVars.gui;
			platformTheme = "gtk";
		};

		programs = {
			home-manager.enable = true;
			alacritty.enable = config.customVars.gui;
			abook.enable = true;
			fzf.enable = true;
			git.enable = true;
			go.enable = true;
			gpg.enable = true;
			htop.enable = true;
			lf.enable = true;
			librewolf.enable = config.customVars.gui;
			man.enable = true;
			mangohud.enable = config.customVars.gui;
			mbsync.enable = true;
			mpv.enable = true;
			msmtp.enable = true;
			ncmpcpp.enable = true;
			neomutt.enable = true;
			neovim.enable = true;
			notmuch.enable = true;
			obs-studio.enable = config.customVars.gui;
			password-store.enable = true;
			ssh.enable = true;
			texlive.enable = true;
			tmux.enable = true;
			zathura.enable = config.customVars.gui;
			zsh.enable = osConfig.users.users."${config.home.username}".shell == pkgs.zsh;

			waybar = {
				enable = config.customVars.gui;
			};
		};

		services = {
			dunst.enable = config.customVars.gui;
			gpg-agent.enable = true;
			mpd.enable = true;
			swayidle.enable = config.wayland.windowManager.sway.enable;
		};
	};
}
