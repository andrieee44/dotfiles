{
	fonts.fontconfig.enable = true;
	wayland.windowManager.hyprland.enable = true;
	custom.eww.enable = true;

	home = {
		packages = [
			glxinfo
			grim
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
			noto-fonts-color-emoji
			noto-fonts-emoji-blob-bin
			noto-fonts-lgc-plus
			noto-fonts-monochrome-emoji
			vistafonts
			wl-clipboard
		];

		sessionVariables = {
			BROWSER = "firefox-esr";
			TERMINAL = "${pkgs.foot}/bin/footclient";
		};
	};

	programs = {
		firefox.enable = true;
		hyprlock.enable = true;
		imv.enable = true;
		mangohud.enable = true;
		mpv.enable = true;
		obs-studio.enable = true;
		zathura.enable = true;
	};

	services = {
		hypridle.enable = true;
		mako.enable = true;
	};

	gtk = {
		enable = true;
		gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
	};
}
