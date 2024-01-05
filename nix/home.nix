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
			stateVersion = osConfig.system.stateVersion;
			enableNixpkgsReleaseCheck = true;

			packages = lib.mkMerge [
				(with pkgs; [
					(lib.mkIf config.services.mpd.enable mpc-cli)
					(lib.mkIf config.programs.go.enable gotools)
					moar
					bc
					neofetch
					powertop
					xdg-user-dirs
					hugo
					go-mtpfs
				])

				(with config.customVars.fzfscripts; [
					pathmenu
					sysmenu
				])

				(lib.optionals config.customVars.gui (with pkgs; [
					glxinfo
					grim
					wl-clipboard
					gamemode
					pcsx2
					rpcs3
					wineWowPackages.full
					winetricks
				]))
			];

			shellAliases = let
				unixUtils = config.customVars.unixUtils;
			in {
				less = "\${PAGER}";
				cp = "${unixUtils}/cp -iv";
				mv = "${unixUtils}/mv -iv";
				rm = "${unixUtils}/rm -iv";
				mkdir = "${unixUtils}/mkdir -pv";
				rmdir = "${unixUtils}/rmdir -p";
				ip = "${pkgs.iproute2}/bin/ip -color=auto";
				df = "${unixUtils}/df -Pha";
				bc = "${pkgs.bc}/bin/bc ${config.home.homeDirectory}/${config.xdg.configFile.bcrc.target} -ql";
				ls = "LC_ALL=C ${pkgs.coreutils}/bin/ls -AFhl --time=birth --time-style='+%b %e %Y (%a) %l:%M %p' --color=auto --group-directories-first";
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
			cacheHome = "${config.home.homeDirectory}/.cache";
			dataHome = "${config.home.homeDirectory}/.local/share";
			stateHome = "${config.home.homeDirectory}/.local/state";

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
			font.size = 14;
			cursorTheme.size = 32;
		};

		qt = {
			enable = config.customVars.gui;
			platformTheme = "gtk";
		};

		programs = {
			alacritty.enable = config.customVars.gui;
			abook.enable = true;
			dircolors.enable = true;
			fzf.enable = true;
			git.enable = true;
			go.enable = true;
			gpg.enable = true;
			home-manager.enable = true;
			htop.enable = true;
			imv.enable = true;
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
			swaylock.enable = config.wayland.windowManager.sway.enable;
			texlive.enable = true;
			tmux.enable = true;
			waybar.enable = config.wayland.windowManager.sway.enable;
			zathura.enable = config.customVars.gui;
			zsh.enable = osConfig.users.users."${config.home.username}".shell == pkgs.zsh;
		};

		services = {
			dunst.enable = config.customVars.gui;
			gpg-agent.enable = true;
			mpd.enable = true;
			swayidle.enable = config.wayland.windowManager.sway.enable;
		};
	};
}
