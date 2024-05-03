{ config, pkgs, inputs, colorscheme, stateVersion, ... }:
{
	fonts.fontconfig.enable = true;
	nixpkgs.config.allowUnfree = true;
	wayland.windowManager.hyprland.enable = true;

	home = {
		stateVersion = stateVersion;
		sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
		pointerCursor.gtk.enable = true;

		packages = with pkgs; [
			bc
			dolphin-emu
			eww
			ffmpeg
			glxinfo
			go-mtpfs
			gotools
			grim
			hugo
			mpc-cli
			neofetch
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
			noto-fonts-color-emoji
			noto-fonts-emoji-blob-bin
			noto-fonts-lgc-plus
			noto-fonts-monochrome-emoji
			pcsx2
			powertop
			ppsspp
			rpcs3
			#vinegar
			vistafonts
			winetricks
			wineWowPackages.full
			wl-clipboard
			xdg-user-dirs
		];

		shellAliases = {
			bc = "bc ${config.home.homeDirectory}/${config.xdg.configFile."bc/bcrc".target} -ql";
			cp = "cp -iv";
			df = "df -Pha";
			diff = "diff --color=auto";
			grep = "grep --color=auto";
			ip = "ip -color=auto";
			less = config.home.sessionVariables.PAGER;
			ls = "LC_ALL=C ls -AFhl --time=birth --time-style='+%b %e %Y (%a) %l:%M %p' --color=auto --group-directories-first";
			mkdir = "mkdir -pv";
			mv = "mv -iv";
			nix-shell = "HISTFILE=${config.xdg.dataHome}/nix-shell.history nix-shell";
			rmdir = "rmdir -p";
			rm = "rm -iv";
		};

		sessionVariables = {
			LESSHISTFILE = "-";
			NPM_CONFIG_USERCONFIG = "${config.home.homeDirectory}/${config.xdg.configFile."npm/npmrc".target}";
			SSH_ASKPASS_REQUIRE = "force";
			W3M_DIR = "${config.xdg.dataHome}/w3m";
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
		aerc.enable = true;
		dircolors.enable = true;
		direnv.enable = true;
		#eww.enable = true;
		firefox.enable = true;
		foot.enable = true;
		fzf.enable = true;
		git.enable = true;
		go.enable = true;
		gpg.enable = true;
		htop.enable = true;
		hyprlock.enable = true;
		imv.enable = true;
		lf.enable = true;
		librewolf.enable = true;
		man.enable = true;
		mangohud.enable = true;
		mbsync.enable = true;
		mpv.enable = true;
		msmtp.enable = true;
		ncmpcpp.enable = true;
		nixvim.enable = true;
		notmuch.enable = true;
		obs-studio.enable = true;
		password-store.enable = true;
		ssh.enable = true;
		starship.enable = true;
		texlive.enable = true;
		tmux.enable = true;
		zathura.enable = true;
		zsh.enable = true;
	};

	services = {
		gpg-agent.enable = true;
		hypridle.enable = true;
		mako.enable = true;
		mbsync.enable = true;
		mpd.enable = true;
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
		enable = true;
		gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

		font = {
			package = pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; };
			name = "SauceCodePro Nerd Font Mono";
			size = 14;
		};

		theme = {
			name = colorscheme.slug;
			package = (inputs.nix-colors.lib.contrib { inherit pkgs; }).gtkThemeFromScheme { scheme = colorscheme; };
		};
	};

	qt = {
		enable = config.gtk.enable;
		platformTheme.name = "gtk";
	};
}
