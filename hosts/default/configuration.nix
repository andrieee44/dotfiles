{ config, pkgs, colorscheme, stateVersion, ... }:
{
	time.timeZone = "Asia/Manila";
	system.stateVersion = stateVersion;

	environment = {
		systemPackages = with pkgs; [ home-manager ];
		pathsToLink = [ "/share/zsh" ];
	};

	programs = {
		dconf.enable = true;
		zsh.enable = true;

		light = {
			enable = true;

			brightnessKeys = {
				enable = true;
				step = 10;
			};
		};

		ssh = {
			startAgent = true;
			agentTimeout = null;
			extraConfig = "AddKeysToAgent yes";
		};
	};

	services = {
		thermald.enable = true;

		xserver = {
			autoRepeatDelay = 10;
			autoRepeatInterval = 10;
			xkb.options = "caps:escape";
		};

		pipewire = {
			enable = true;
			audio.enable = true;
			socketActivation = true;
			wireplumber.enable = true;
			pulse.enable = true;

			alsa = {
				enable = true;
				support32Bit = true;
			};
		};

		tlp.settings = {
			enable = true;
			BAY_POWEROFF_ON_AC = 1;
			BAY_POWEROFF_ON_BAT = 1;
			CPU_ENERGY_PERC_POLICY_ON_AC = "performance";
			CPU_ENERGY_PERC_POLICY_ON_BAT = "power";
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
			DEVICES_TO_DISABLE_ON_STARTUP = "wifi bluetooth wwan";
			RESTORE_THRESHOLDS_ON_BAT = 1;
			SOUND_POWER_SAVE_ON_BAT = 10;
			STOP_CHARGE_THRESH_BAT0 = 1;
		};
	};

	hardware = {
		steam-hardware.enable = config.programs.steam.enable;
		enableAllFirmware = true;
		bluetooth.powerOnBoot = false;

		opengl = let
			extraPkgs = with pkgs; [
				intel-media-driver
				vaapiIntel
				vaapiVdpau
				libvdpau-va-gl
				rocm-opencl-icd
				rocm-opencl-runtime
			];
		in {
			driSupport = true;
			driSupport32Bit = true;
			extraPackages = extraPkgs;
			extraPackages32 = extraPkgs;
		};
	};

	console = {
		useXkbConfig = true;
		font = "${pkgs.terminus_font}/share/consolefonts/ter-122b.psf.gz";

		colors = [
			colorscheme.palette.base01
			colorscheme.palette.base08
			colorscheme.palette.base0B
			colorscheme.palette.base0A
			colorscheme.palette.base0D
			colorscheme.palette.base0E
			colorscheme.palette.base0C
			colorscheme.palette.base05
			colorscheme.palette.base03
			colorscheme.palette.base08
			colorscheme.palette.base0B
			colorscheme.palette.base0A
			colorscheme.palette.base0D
			colorscheme.palette.base0E
			colorscheme.palette.base07
			colorscheme.palette.base06
		];
	};

	nix.settings = {
		auto-optimise-store = true;

		experimental-features = [
			"nix-command"
			"flakes"
		];
	};

	nixpkgs.config = {
		allowUnfree = true;

		packageOverrides = pkgs:
			{
				vaapiIntel = pkgs.vaapiIntel.override {
					enableHybridCodec = true;
				};
			};
	};

	boot = {
		kernelPackages = pkgs.linuxKernel.packages.linux_zen;

		tmp = {
			useTmpfs = true;
			cleanOnBoot = true;
		};

		loader = {
			systemd-boot = {
				enable = true;
				editor = false;
				memtest86.enable = true;
				configurationLimit = 50;
			};
		};
	};

	networking.networkmanager = {
		enable = true;
		wifi.powersave = true;
	};

	i18n = {
		defaultLocale = "en_PH.UTF-8";

		extraLocaleSettings = {
			LC_LANGUAGE = config.i18n.defaultLocale;
			LC_ALL = config.i18n.defaultLocale;
		};
	};

	security = {
		polkit.enable = true;
		rtkit.enable = true;

		wrappers.intel_gpu_top = {
			owner = "root";
			group = "wheel";
			capabilities = "cap_perfmon+ep";
			source = "${pkgs.intel-gpu-tools}/bin/intel_gpu_top";
		};

		pam = {
			services = {
				swaylock.gnupg.enable = true;

				login.gnupg = {
					enable = true;
					storeOnly = true;
				};
			};

			loginLimits = [
				{
					domain = "@wheel";
					type = "-";
					item = "memlock";
					value = "unlimited";
				}
			];
		};
	};

	xdg.portal = {
		wlr.enable = true;
		config.common.default = [ "gtk" ];
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
	};
}
