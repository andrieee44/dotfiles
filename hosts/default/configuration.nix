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
		light.enable = true;
		hyprland.enable = true;
	};

	services = {
		thermald.enable = true;
		pipewire.enable = true;
		tlp.enable = true;
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
			colorscheme.palette.base00
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
			colorscheme.palette.base0C
			colorscheme.palette.base07
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
