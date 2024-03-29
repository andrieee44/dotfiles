{ config, pkgs, inputs, colorscheme, stateVersion, ... }:
{
	nixpkgs.config.allowUnfree = true;

	accounts.email.accounts."${config.home.username}" = {
		gpg.signByDefault = true;
		notmuch.enable = config.programs.notmuch.enable;
		maildir.path = config.accounts.email.accounts."${config.home.username}".address;

		mbsync = {
			enable = config.programs.mbsync.enable;
			create = "both";
		};

		neomutt = {
			enable = config.programs.neomutt.enable;

			extraConfig = ''
				color normal default default
				color index brightblue default ~N
				color index red default ~F
				color index blue default ~T
				color index brightred default ~D
				color body brightgreen default (https?|ftp)://[\-\.+,/%~_:?&=\
				color body brightgreen default [\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+
				color attachment magenta default
				color signature brightwhite default
				color search brightred black

				color indicator black cyan
				color error red default
				color status white brightblack
				color tree white default
				color tilde cyan default

				color hdrdefault brightblue default
				color header cyan default "^From:"
				color header cyan default "^Subject:"

				color quoted cyan default
				color quoted1 brightcyan default
				color quoted2 blue default
				color quoted3 green default
				color quoted4 yellow default
				color quoted5 red default
			'';
		};
	};

	home = {
		stateVersion = stateVersion;
		sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
		pointerCursor.gtk.enable = true;

		packages = with pkgs; [
			mpc-cli
			bc
			neofetch
			powertop
			xdg-user-dirs
			hugo
			go-mtpfs
			ffmpeg
			glxinfo
			grim
			wl-clipboard
			gotools
		];

		shellAliases = {
			less = "\${PAGER}";
			cp = "cp -iv";
			mv = "mv -iv";
			rm = "rm -iv";
			mkdir = "mkdir -pv";
			rmdir = "rmdir -p";
			ip = "ip -color=auto";
			df = "df -Pha";
			bc = "bc ${config.home.homeDirectory}/${config.xdg.configFile.bcrc.target} -ql";
			ls = "LC_ALL=C ls -AFhl --time=birth --time-style='+%b %e %Y (%a) %l:%M %p' --color=auto --group-directories-first";
			grep = "grep --color=auto";
			diff = "diff --color=auto";
			nix-shell = "HISTFILE=${config.xdg.dataHome}/nix-shell.history nix-shell";
		};

		sessionVariables = {
			LESSHISTFILE = "-";
			NPM_CONFIG_USERCONFIG = "${config.home.homeDirectory}/${config.xdg.configFile.npmrc.target}";
			W3M_DIR = "${config.xdg.dataHome}/w3m";
			SSH_ASKPASS_REQUIRE = "force";
		};

		language = let
			locale = "fil_PH";
			defaultLocale = "en_PH.UTF-8";
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

		pointerCursor = {
			package = pkgs.vanilla-dmz;
			name = "Vanilla-DMZ";
		};
	};

	programs = {
		abook.enable = true;
		dircolors.enable = true;
		fzf.enable = true;
		git.enable = true;
		go.enable = true;
		gpg.enable = true;
		htop.enable = true;
		imv.enable = true;
		lf.enable = true;
		man.enable = true;
		mbsync.enable = true;
		mpv.enable = true;
		msmtp.enable = true;
		ncmpcpp.enable = true;
		neomutt.enable = true;
		nixvim.enable = true;
		notmuch.enable = true;
		obs-studio.enable = true;
		password-store.enable = true;
		ssh.enable = true;
		swaylock.enable = config.wayland.windowManager.sway.enable;
		texlive.enable = true;
		tmux.enable = true;
		waybar.enable = config.wayland.windowManager.sway.enable;
		zathura.enable = true;
		zsh.enable = true;
	};

	services = {
		gpg-agent.enable = true;
		mpd.enable = true;
		swayidle.enable = config.wayland.windowManager.sway.enable;
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
		gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

		font = {
			package = pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; };
			name = "Sauce Code Pro Nerd Font Mono";
			size = 14;
		};

		theme = {
			name = colorscheme.slug;
			package = (inputs.nix-colors.lib.contrib { inherit pkgs; }).gtkThemeFromScheme { scheme = colorscheme; };
		};
	};

	qt = {
		enable = config.gtk.enable;
		platformTheme = "gtk";
	};
}
