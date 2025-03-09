{
  config,
  pkgs,
  lib,
  ...
}:
{
  custom.programs.calcurse = {
    caldav.settings = {
      General = {
        Hostname = "apidata.googleusercontent.com";
        Path = "/caldav/v2/CALENDAR_ID/events/";
        InsecureSSL = "No";
        HTTPS = "Yes";
        SyncFilter = "cal";
        DryRun = "No";
        Verbose = "Yes";
        AuthMethod = "oauth2";
      };

      OAuth2 = {
        ClientID = "CLIENT_ID";
        ClientSecret = "CLIENT_SECRET";
        Scope = "https://www.googleapis.com/auth/calendar";
        RedirectURI = "http://127.0.0.1";
      };
    };

    settings = {
      general.firstdayofweek = "sunday";
      appearance.theme = "blue on default";
    };

    keys = {
      generic-cancel = "ESC";
      generic-select = "SPC";
      generic-credits = "@";
      generic-help = "?";
      generic-quit = "q Q";
      generic-save = "s S ^S";
      generic-reload = "R";
      generic-copy = "c";
      generic-paste = "p ^V";
      generic-change-view = "TAB";
      generic-prev-view = "KEY_BTAB";
      generic-import = "i I";
      generic-export = "x X";
      generic-goto = "g G";
      generic-other-cmd = "o O";
      generic-config-menu = "C";
      generic-redraw = "^R";
      generic-add-appt = "^A";
      generic-add-todo = "^T";
      generic-prev-day = "T ^H";
      generic-next-day = "t ^L";
      generic-prev-week = "W ^K";
      generic-next-week = "w";
      generic-prev-month = "M";
      generic-next-month = "m";
      generic-prev-year = "Y";
      generic-next-year = "y";
      generic-scroll-down = "^N";
      generic-scroll-up = "^P";
      generic-goto-today = "^G";
      generic-command = ":";
      move-right = "l L RGT";
      move-left = "h H LFT";
      move-down = "j J DWN";
      move-up = "k K UP";
      start-of-week = "0";
      end-of-week = "$";
      add-item = "a A";
      del-item = "d D";
      edit-item = "e E";
      view-item = "v V RET";
      pipe-item = "|";
      flag-item = "!";
      repeat = "r";
      edit-note = "n N";
      view-note = ">";
      raise-priority = "+";
      lower-priority = "-";
    };
  };

  home.shellAliases.calcurse =
    let
      customPrograms = config.custom.programs;
      pass = config.programs.password-store;
      pass-data = customPrograms.pass-data;
      calcurse = customPrograms.calcurse;
    in
    lib.mkIf (calcurse.enable && pass.enable && pass-data.enable) (
      builtins.toString (
        pkgs.writers.writeDash "calcurseData" ''
          set -eu

          ${pass.package}/bin/pass data "data/calcurse" "${calcurse.package}/bin/calcurse" -C "${config.xdg.configHome}/calcurse" -D '"$PASS_DATA"' "$@"
        ''
      )
    );
}
