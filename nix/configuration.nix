{ config, pkgs, lib, ... }:
{
	imports = [
		<home-manager/nixos>
		/etc/nixos/hardware-configuration.nix
		./customVars.nix
	] ++ import ./importPath.nix lib ./configuration;

	config = {
		home-manager.users."${config.customVars.user}".imports = [
			./home.nix
		];

		time.timeZone = "Asia/Manila";
		console.enable = true;

		nixpkgs.config = {
			allowUnfree = true;

			packageOverrides = pkgs: {
				vaapiIntel = pkgs.vaapiIntel.override {
					enableHybridCodec = true;
				};
			};
		};

		fonts = {
			fonts = with pkgs; [
				(nerdfonts.override {
					fonts = [
						"SourceCodePro"
					];
				})

				vistafonts
			];

			fontconfig = {
				includeUserConf = true;
				enable = true;

				defaultFonts = {
					emoji = [
						"SauceCodePro Nerd Font"
					];

					serif = [
						"SauceCodePro Nerd Font"
					];

					sansSerif = [
						"SauceCodePro Nerd Font"
					];

					monospace = [
						"SauceCodePro Nerd Font Mono"
					];
				};
			};
		};

		boot = {
			tmpOnTmpfs = true;

			loader = {
				systemd-boot = {
					enable = true;
					editor = false;
					configurationLimit = 50;
				};

				efi = {
					canTouchEfiVariables = true;
					efiSysMountPoint = "/boot/efi";
				};
			};
		};

		networking = {
			hostName = "nixos";
			networkmanager.enable = true;
		};

		i18n = {
			defaultLocale = "en_PH.UTF-8";

			extraLocaleSettings = {
				LC_LANGUAGE = config.i18n.defaultLocale;
				LC_ALL = config.i18n.defaultLocale;
			};
		};

		system = {
			stateVersion = "23.05";

			autoUpgrade = {
				enable = false;
				allowReboot = false;
			};
		};

		users.users."${config.customVars.user}" = {
			isNormalUser = true;
			description = config.customVars.name;
			shell = pkgs.zsh;
			createHome = true;

			extraGroups = [
				"networkmanager"
				"wheel"
				"audio"
				"video"
				"input"
				"floppy"
				"render"
			];
		};

		environment = {
			pathsToLink = [
				(lib.optionalString config.programs.zsh.enableCompletion "/share/zsh")
			];

			shells = [
				config.users.users."${config.customVars.user}".shell
			];

			systemPackages = with pkgs; [
				terminus_font
			];
		};

		security = {
			polkit.enable = true;
			rtkit.enable = true;

			pam.services = {
				swaylock.gnupg.enable = true;

				login.gnupg = {
					enable = true;
					storeOnly = true;
				};
			};
		};

		programs = {
			steam.enable = config.customVars.gui;
			dconf.enable = true;
			light.enable = true;

			gamemode = {
				enable = config.customVars.gui;
				enableRenice = true;
			};
		};

		services = {
			pipewire.enable = true;
			tlp.enable = true;
			thermald.enable = true;
			blueman.enable = true;

			xserver = {
				xkbOptions = "caps:escape";
			};
		};

		hardware = {
			bluetooth = {
				enable = true;
			};

			opengl = {
				enable = config.customVars.gui;
				extraPackages = with pkgs; [
					intel-media-driver
					vaapiIntel
					vaapiVdpau
					libvdpau-va-gl
				];
			};

			steam-hardware.enable = config.customVars.gui;
		};

		xdg.portal ={
			enable = true;
			wlr.enable = config.customVars.gui;

			extraPortals = with pkgs; [
				(lib.mkIf config.customVars.gui xdg-desktop-portal-gtk)
			];
		};
	};
}
