{
  config,
  pkgs,
  stateVersion,
  ...
}:
{
  time.timeZone = "Asia/Manila";
  system.stateVersion = stateVersion;
  environment.pathsToLink = [ "/share/zsh" ];

  users = {
    defaultUserShell = pkgs.zsh;
    groups.nix-on-droid = { };

    users = {
      andrieee44 = {
        createHome = true;
        group = "users";
        isNormalUser = true;
        shell = pkgs.zsh;

        extraGroups = [
          "audio"
          "floppy"
          "input"
          "networkmanager"
          "render"
          "video"
          "wheel"
        ];
      };

      nix-on-droid = {
        group = "nix-on-droid";
        isSystemUser = true;
      };
    };
  };

  security.sudo = {
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  programs = {
    dconf.enable = true;
    gamemode.enable = true;
    hyprland.enable = true;
    light.enable = true;
    zsh.enable = true;

    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      gamescopeSession.enable = true;
    };
  };

  services = {
    flatpak.enable = true;
    openssh.enable = true;
    pipewire.enable = true;
    thermald.enable = true;
    tlp.enable = true;
  };

  hardware = {
    enableAllFirmware = true;
    steam-hardware.enable = config.programs.steam.enable;

    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-122b.psf.gz";
    useXkbConfig = true;
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

    packageOverrides = pkgs: { vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; }; };
  };

  boot = {
    plymouth.enable = true;
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
        configurationLimit = 100;
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
        hyprlock = { };

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
}
