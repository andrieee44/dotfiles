# https://github.com/nix-community/home-manager/blob/298ca185ffea6792b469720e95de1b9d0ec0c735/modules/programs/calcurse.nix
{
  config,
  lib,
  pkgs,
  ...
}:
let
  iniFormat = pkgs.formats.ini { };

  formatLine =
    o: n: v:
    let
      formatValue =
        v:
        if builtins.isNull v then
          "None"
        else if builtins.isBool v then
          (if v then "yes" else "no")
        else if builtins.isString v then
          "${v}"
        else if builtins.isList v then
          "${lib.concatStringsSep " " (map formatValue v)}"
        else
          builtins.toString v;
    in
    if o == "" then "${n}  ${formatValue v}" else "${o}${n}=${formatValue v}";
in
{
  meta.maintainers = [ lib.hm.maintainers.omernaveedxyz ];

  options.custom.programs.calcurse = {
    enable = lib.mkEnableOption "calcurse - a text-based calendar and scheduling application";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.calcurse;
      defaultText = "pkgs.calcurse";
      description = "Package containing the <command>calcurse</command> executable.";
    };

    hooks = {
      preLoad = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Script ran before loading Calcurse calendar.";

        example = lib.literalExpression ''
          #!/bin/sh
          notify-send "Loaded calendar"
        '';
      };

      postLoad = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Script ran after loading Calcurse calendar.";

        example = lib.literalExpression ''
          #!/bin/sh
          notify-send "Loaded calendar"
        '';
      };

      preSave = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Script ran before saving Calcurse calendar.";

        example = lib.literalExpression ''
          #!/bin/sh
          notify-send "Saved calendar"
        '';
      };

      postSave = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Script ran after saving Calcurse calendar.";

        example = lib.literalExpression ''
          #!/bin/sh
          notify-send "Saved calendar"
        '';
      };
    };

    caldav.settings = lib.mkOption {
      type = iniFormat.type;
      default = { };
      description = "calcurse-caldav plugin settings.";

      example = lib.literalExpression ''
        {
          General = {
            Binary = "calcurse";
            Hostname = "example.com";
            Path = "/";
            InsecureSSL = "No";
            HTTPS = "Yes";
            SyncFilter = "cal,todo";
            DryRun = "No";
            Verbose = "Yes";
          };

          Auth = {
            Username = "username";
            Password = "password";
          };
        };
      '';
    };

    settings = {
      general = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = { };
        description = "Calcurse 'general' settings.";

        example = lib.literalExpression ''
          {
            autogc = false;
            autosave = true;
          };
        '';
      };

      appearance = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = { };
        description = "Calcurse 'appearance' settings.";

        example = lib.literalExpression ''
          {
            calendarview = "monthly";
            compactpanels = false;
          };
        '';
      };

      format = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = { };
        description = "Calcurse 'format' settings.";

        example = lib.literalExpression ''
          {
            notifydate = "%a %F";
            notifytime = "%T";
          };
        '';
      };
    };

    keys = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = { };
      description = "Calcurse keybinds.";

      example = lib.literalExpression ''
        {
          generic-cancel = "ESC";
          generic-select = "SPC";
        };
      '';
    };
  };

  config =
    let
      cfg = config.custom.programs.calcurse;
      caldavConfigFile = iniFormat.generate "config" cfg.caldav.settings;
    in
    lib.mkIf cfg.enable {
      home.packages = [ cfg.package ];
      assertions = [ (lib.hm.assertions.assertPlatform "programs.calcurse" pkgs lib.platforms.linux) ];

      xdg.configFile = {
        "calcurse/caldav/config" = lib.mkIf (cfg.caldav.settings != { }) { source = caldavConfigFile; };

        "calcurse/conf" = {
          text = lib.concatStringsSep "\n" (
            lib.mapAttrsToList (formatLine "appearance.") cfg.settings.appearance
            ++ lib.mapAttrsToList (formatLine "general.") cfg.settings.general
            ++ lib.mapAttrsToList (formatLine "format.") cfg.settings.format
          );
        };

        "calcurse/keys" = lib.mkIf (cfg.keys != { }) {
          text = lib.concatStringsSep "\n" (lib.mapAttrsToList (formatLine "") cfg.keys);
        };

        "calcurse/hooks/pre-load" = lib.mkIf (cfg.hooks.preLoad != "") {
          text = cfg.hooks.preLoad;
          executable = true;
        };

        "calcurse/hooks/post-load" = lib.mkIf (cfg.hooks.postLoad != "") {
          text = cfg.hooks.postLoad;
          executable = true;
        };

        "calcurse/hooks/pre-save" = lib.mkIf (cfg.hooks.preSave != "") {
          text = cfg.hooks.preSave;
          executable = true;
        };

        "calcurse/hooks/post-save" = lib.mkIf (cfg.hooks.postSave != "") {
          text = cfg.hooks.postSave;
          executable = true;
        };
      };
    };
}
