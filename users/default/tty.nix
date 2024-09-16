{ config, pkgs, lib, stateVersion, ... }:
{
	nixpkgs.config.allowUnfree = true;

	custom.programs = {
		cmenu.enable = true;
		spotdl.enable = true;
	};

	accounts.email = {
		maildirBasePath = "${config.xdg.dataHome}/maildir";

		accounts."andrieee44@gmail.com" = let
			signatureText = "-- \n\"The art of programming is the art of organizing complexity.\" -Edsger Dijkstra";
		in {
			address = "andrieee44@gmail.com";
			flavor = "gmail.com";
			passwordCommand = "${pkgs.pass}/bin/pass web/gmailApp";
			primary = true;
			realName = "andrieee44";
			userName = "andrieee44";
			maildir.path = "andrieee44@gmail.com";
			msmtp.enable = true;
			notmuch.enable = true;

			aerc = {
				enable = true;

				extraAccounts = {
					signature-file = builtins.toFile "signature.txt" signatureText;
					pgp-auto-sign = true;
					pgp-attach-key = true;
				};
			};

			gpg = {
				key = "B936 149C 88D4 64B3 DC0B 9F0D A555 AF06 F5A8 0AB1";
				signByDefault = true;
			};

			mbsync = {
				enable = true;
				create = "maildir";
				expunge = "maildir";
				subFolders = "Maildir++";
			};

			signature = {
				text = signatureText;
				showSignature = "append";
			};
		};
	};

	home = {
		stateVersion = stateVersion;
		sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

		packages = with pkgs; [
			bc
			ffmpeg
			go-mtpfs
			gotools
			hugo
			mpc-cli
			neofetch
			powertop
			xdg-user-dirs
		];

		shellAliases = let
			toybox = "${pkgs.toybox}/bin/";
			coreutils = "${pkgs.coreutils}/bin/";
		in {
			bc = "${pkgs.bc}/bin/bc ${config.home.homeDirectory}/${config.xdg.configFile."bc/bcrc".target} -ql";
			cp = "${toybox}/cp -iv";
			df = "${toybox}/df -Pha";
			diff = "${pkgs.diffutils}/bin/diff --color=auto";
			grep = "${pkgs.gnugrep}/bin/grep --color=auto";
			ip = "${pkgs.iproute2}/bin/ip -color=auto";
			less = config.home.sessionVariables.PAGER;
			ls = "LC_ALL=C ${coreutils}/ls -AFhl --time=birth --time-style='+%b %e %Y (%a) %l:%M %p' --color=auto --group-directories-first";
			mkdir = "${toybox}/mkdir -pv";
			mv = "${toybox}/mv -iv";
			nix-shell = "HISTFILE=${config.xdg.dataHome}/nix-shell.history ${pkgs.nix}/bin/nix-shell";
			rmdir = "${toybox}/rmdir -p";
			rm = "${toybox}/rm -iv";
		};

		sessionVariables = {
			BROWSER = lib.mkDefault "";
			EDITOR = "nvim";
			LESSHISTFILE = "-";
			NPM_CONFIG_USERCONFIG = "${config.home.homeDirectory}/${config.xdg.configFile."npm/npmrc".target}";
			PAGER = "${pkgs.less}/bin/less";
			SSH_ASKPASS_REQUIRE = "force";
			TERMINAL = lib.mkDefault "";
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
		};
	};

	programs = {
		aerc.enable = true;
		dircolors.enable = true;
		direnv.enable = true;
		fzf.enable = true;
		go.enable = true;
		home-manager.enable = true;
		htop.enable = true;
		irssi.enable = true;
		lf.enable = true;
		man.enable = true;
		mbsync.enable = true;
		msmtp.enable = true;
		ncmpcpp.enable = true;
		nixvim.enable = true;
		notmuch.enable = true;
		password-store.enable = true;
		ssh.enable = true;
		starship.enable = true;
		texlive.enable = true;
		tmux.enable = true;
		zsh.enable = true;

		git = {
			enable = true;
			userEmail = "andrieee44@gmail.com";
		};

		gpg = {
			enable = true;

			publicKeys = [
				{
					trust = 5;
					source = ./public.key;
				}
			];
		};
	};

	services = {
		gpg-agent.enable = true;
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

		configFile.pam-gnupg = {
			enable = config.services.gpg-agent.enable;

			text = ''
				${config.programs.gpg.homedir}
				4761373E4C1DF3223D5D82B64B2B4D7665A3138B
			'';
		};
	};
}
