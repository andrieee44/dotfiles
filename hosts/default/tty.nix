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
  users.defaultUserShell = pkgs.zsh;

  security.sudo = {
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  programs = {
    dconf.enable = true;
    light.enable = true;
    zsh.enable = true;
  };

  services = {
    flatpak.enable = true;
    fstrim.enable = true;
    openssh.enable = true;
    pipewire.enable = true;
    thermald.enable = true;
    tlp.enable = true;
    udev.enable = true;
  };

  hardware = {
    enableAllFirmware = true;
    intel-gpu-tools.enable = true;

    cpu = {
      amd.updateMicrocode = true;
      intel.updateMicrocode = true;
    };

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
      cleanOnBoot = true;
      tmpfsSize = "100%";
      useTmpfs = true;
    };

    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        memtest86.enable = true;
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

    pam = {
      services = {
        hyprlock = { };

        login.gnupg = {
          enable = true;
          noAutostart = true;
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
