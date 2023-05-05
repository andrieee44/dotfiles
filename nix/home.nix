{ config, pkgs, lib, ... }:
{
	imports = [
		./customVars.nix
	] ++ import ./importPath.nix lib ./home;

	wayland.windowManager.sway.enable = config.customVars.gui;
	nixpkgs.config.allowUnfree = true;
	fonts.fontconfig.enable = true;

	home = {
		username = config.customVars.user;
		homeDirectory = "/home/${config.customVars.user}";
		stateVersion = "22.11";
		enableNixpkgsReleaseCheck = true;

		packages = lib.mkMerge [
			(with pkgs; [
				(lib.mkIf config.services.mpd.enable mpc-cli)
				bc
				neofetch
				powertop
				xdg-user-dirs
			])

			(lib.mkIf config.customVars.gui (with pkgs; [
				lutris
				glxinfo
				grim
				wl-clipboard
			]))
		];

		shellAliases =  {
			cp = "cp -iv";
			mv = "mv -iv";
			rm = "rm -Iv";
			ip = "ip -color=auto";
			df = "df -PTha";
			bc = "bc ${config.home.file.bcrc.target} -ql";
			ls = "LC_ALL=C ls -AFhl --time=use --time-style='+%b %e %Y (%a) %l:%M %p' --color=auto --group-directories-first";
			grep = "grep --color=auto";
			diff = "diff --color=auto";
			ccat = "highlight --out-format=ansi";
			mkdir = "mkdir -pv";
			rmdir = "rmdir -pv";
		};

		sessionVariables = {
			LESSHISTFILE = "-";
			CARGO_HOME = "${config.xdg.dataHome}/cargo";
			WEECHAT_HOME = "${config.xdg.configHome}/weechat";
			ELECTRUMDIR = "${config.xdg.dataHome}/electrum";
		};

		language = let
			locale = "fil_PH";
		in
		{
			address = locale;
			base = config.customVars.characterSet;
			collate = config.customVars.characterSet;
			measurement = locale;
			messages = config.customVars.characterSet;
			name = locale;
			numeric = locale;
			paper = locale;
			telephone = locale;
			time = locale;
		};
	};

	xdg = {
		enable = true;
		mime.enable = true;
		mimeApps.enable = true;

		userDirs = let
			baseDir = "${config.home.homeDirectory}/xdg";
		in
		{
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

		cursorTheme = {
			package = pkgs.nordzy-cursor-theme;
			name = "Nordzy-cursors";
			size = 16;
		};

		iconTheme = {
			package = pkgs.nordzy-icon-theme;
			name = "Nordzy-dark";
		};

		font = {
			package = pkgs.nerdfonts.override {
				fonts = [
					"SourceCodePro"
				];
			};

			name = "Sauce Code Pro Nerd Font Mono";
			size = 12;
		};

		theme = {
			package = pkgs.nordic;
			name = "Nordic";
		};
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
		zsh.enable = lib.mkIf (config.customVars.shell == pkgs.zsh) true;

		waybar = {
			enable = config.customVars.gui;
		};
	};

	services = {
		dunst.enable = true;
		gpg-agent.enable = true;
		mpd.enable = true;
		swayidle.enable = config.wayland.windowManager.sway.enable;
	};
}
