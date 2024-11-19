{
  config,
  pkgs,
  lib,
  inputs,
  stateVersion,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  accounts.email.maildirBasePath = "${config.xdg.dataHome}/maildir";

  custom.programs = {
    cmenu.enable = true;
    line2json.enable = true;
    spotdl.enable = true;
    tview.enable = true;
  };

  home = {
    stateVersion = stateVersion;
    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

    packages = with pkgs; [
      bc
      ffmpeg
      findutils
      gnused
      go-mtpfs
      gotools
      hugo
      mpc-cli
      neofetch
      powertop
      xdg-user-dirs
    ];

    shellAliases =
      let
        toybox = "${pkgs.toybox}/bin/";
        coreutils = "${pkgs.coreutils}/bin/";
      in
      {
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
      EDITOR = lib.mkForce "${config.programs.nixvim.build.package}/bin/nvim";
      LESSHISTFILE = "-";
      NPM_CONFIG_USERCONFIG = "${config.home.homeDirectory}/${config.xdg.configFile."npm/npmrc".target}";
      PAGER = "${pkgs.less}/bin/less";
      SSH_ASKPASS_REQUIRE = "force";
      TERMINAL = lib.mkDefault "";
      W3M_DIR = "${config.xdg.dataHome}/w3m";
    };

    language =
      let
        locale = "fil_PH";
        defaultLocale = "en_PH.UTF-8";
      in
      {
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
    bat.enable = true;
    dircolors.enable = true;
    direnv.enable = true;
    fzf.enable = true;
    git.enable = true;
    gpg.enable = true;
    go.enable = true;
    home-manager.enable = true;
    htop.enable = true;
    irssi.enable = true;
    lf.enable = true;
    man.enable = true;
    mbsync.enable = true;
    msmtp.enable = true;
    mu.enable = true;
    ncmpcpp.enable = true;
    nixvim.enable = true;
    notmuch.enable = true;
    password-store.enable = true;
    ssh.enable = true;
    starship.enable = true;
    texlive.enable = true;
    tmux.enable = true;
    zsh.enable = true;

  };

  services = {
    gpg-agent.enable = true;
    ssh-agent.enable = true;
    mbsync.enable = true;
    mpd.enable = true;
  };

  xdg =
    let
      baseDir = "${config.home.homeDirectory}/xdg";
    in
    {
      enable = true;
      mime.enable = true;
      mimeApps.enable = true;
      configHome = "${config.home.homeDirectory}/.config";
      cacheHome = "${config.home.homeDirectory}/.cache";
      dataHome = "${config.home.homeDirectory}/.local/share";
      stateHome = "${config.home.homeDirectory}/.local/state";

      userDirs = {
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
}
