{
  config,
  pkgs,
  lib,
  inputs,
  stateVersion,
  ...
}:
{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  accounts.email.maildirBasePath = "${config.xdg.dataHome}/maildir";
  nixpkgs.config.allowUnfree = true;

  custom.programs = {
    calcurse.enable = true;
    cmenu.enable = true;
    line2json.enable = true;
    lsbin.enable = true;
    pass-data.enable = true;
    pwmon.enable = true;
    spotdl.enable = true;
    tview.enable = true;
  };

  home = {
    inherit stateVersion;
    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
    file.".pulse/client.conf".text = "cookie-file = ${config.xdg.cacheHome}/pulse-cookie";

    packages = with pkgs; [
      bc
      ffmpeg
      findutils
      gnused
      go-mtpfs
      go-tools
      golangci-lint
      gotools
      groff
      hugo
      jaq
      mpc-cli
      neofetch
      pandoc
      powertop
      sd
      shellcheck
      shfmt
      unixtools.util-linux
      xdg-user-dirs
    ];

    shellAliases =
      let
        toybox = "${pkgs.toybox}/bin/";
      in
      {
        bc = "${pkgs.bc}/bin/bc ${config.home.homeDirectory}/${config.xdg.configFile."bc/bcrc".target} -ql";
        cp = "${toybox}/cp -iv";
        df = "${toybox}/df -Pha";
        diff = "${pkgs.diffutils}/bin/diff --color=auto";
        grep = "${pkgs.ripgrep}/bin/rg";
        ip = "${pkgs.iproute2}/bin/ip -color=auto";
        less = config.home.sessionVariables.PAGER;
        mkdir = "${toybox}/mkdir -pv";
        mv = "${toybox}/mv -iv";
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
    bash.enable = true;
    dircolors.enable = true;
    direnv.enable = true;
    eza.enable = true;
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
    ripgrep.enable = true;
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
