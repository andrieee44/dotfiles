{ config, pkgs, ... }:
{
  custom.programs.tview = {
    package = pkgs.buildGoModule {
      name = "tview";
      vendorHash = "sha256-MFpcnTUFVlD0ZvJFbeqCorXuSBo2Z9u0E0Hs7lxvg6A=";

      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "tview";
        rev = "bacd3fe795c4153a687d1996b951b35dfa672541";
        hash = "sha256-gcJWRuuuGE6eyCSFiSWmC7TgwpWUL6IaFcacLUYvwx4=";
      };
    };

    settings =
      let
        audio = [ ''${pkgs.mediainfo}/bin/mediainfo -- "$TVIEW_FILE"'' ];
        archive = [ ''${pkgs.atool}/bin/atool -l -- "$TVIEW_FILE"'' ];
        office = [ ''${pkgs.libreoffice}/bin/libreoffice --cat "$TVIEW_FILE"'' ];

        video = [
          ''${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$TVIEW_FILE" -s 0 -o /dev/stdout | ${pkgs.chafa}/bin/chafa -s "${"\${TVIEW_WIDTH}"}x${"\${TVIEW_HEIGHT}"}" $([ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] || ${pkgs.toybox}/bin/printf -- "-f sixels")''
          ''${pkgs.mediainfo}/bin/mediainfo -- "$TVIEW_FILE"''
        ];

        image = [
          ''${pkgs.chafa}/bin/chafa -s "${"\${TVIEW_WIDTH}"}x${"\${TVIEW_HEIGHT}"}" $([ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] || ${pkgs.toybox}/bin/printf -- "-f sixels") "$TVIEW_FILE"''
          ''${pkgs.imagemagick}/bin/magick "$TVIEW_FILE" jpg:- | ${pkgs.chafa}/bin/chafa -s "${"\${TVIEW_WIDTH}"}x${"\${TVIEW_HEIGHT}"}" $([ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] || ${pkgs.toybox}/bin/printf -- "-f sixels")''
          ''${pkgs.mediainfo}/bin/mediainfo -- "$TVIEW_FILE"''
        ];

        jq = [
          ''${pkgs.jaq}/bin/jaq --color always . "$TVIEW_FILE"''
          ''${pkgs.jq}/bin/jq -C . "$TVIEW_FILE"''
        ];

        text = [
          ''${config.programs.bat.package}/bin/bat --color always --paging never --terminal-width "$TVIEW_WIDTH" -- "$TVIEW_FILE"''
          ''${pkgs.sourceHighlight}/bin/source-highlight --failsafe -i "$TVIEW_FILE"''
          ''${pkgs.toybox}/bin/cat -- "$TVIEW_FILE"''
        ];

        html = [
          ''${pkgs.elinks}/bin/elinks -dump 1 -no-references -no-numbering -dump-width "$TVIEW_WIDTH" "$TVIEW_FILE"''
          ''${pkgs.lynx}/bin/lynx -dump -nonumbers -nolist -width "$TVIEW_WIDTH" -- "$TVIEW_FILE"''
          ''${pkgs.w3m}/bin/w3m -dump "$TVIEW_FILE"''
        ];

        diff = [
          ''${pkgs.delta}/bin/delta < "$TVIEW_FILE"''
          ''${pkgs.diff-so-fancy}/bin/diff-so-fancy < "$TVIEW_FILE"''
          ''${pkgs.colordiff}/bin/colordiff < "$TVIEW_FILE"''
        ];
      in
      {
        "audio/aac" = audio;
        "application/x-abiword" = office;
        "image/apng" = image;
        "application/x-freearc" = archive;
        "image/avif" = image;
        "video/x-msvideo" = video;
        "image/bmp" = image;
        "application/x-bzip" = archive;
        "application/x-bzip2" = archive;
        "application/x-cdf" = audio;
        "application/x-csh" = text;
        "text/css" = text;
        "text/csv" = text;
        "application/msword" = office;
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = office;
        "application/gzip" = archive;
        "application/x-gzip" = archive;
        "image/gif" = image;
        "text/html" = html;
        "image/vnd.microsoft.icon" = image;
        "application/java-archive" = archive;
        "image/jpeg" = image;
        "text/javascript" = text;
        "application/json" = jq;
        "application/ld+json" = jq;
        "audio/midi" = audio;
        "audio/x-midi" = audio;
        "audio/mpeg" = audio;
        "video/mp4" = video;
        "video/mpeg" = video;
        "application/vnd.oasis.opendocument.presentation" = office;
        "application/vnd.oasis.opendocument.spreadsheet" = office;
        "application/vnd.oasis.opendocument.text" = office;
        "audio/ogg" = audio;
        "video/ogg" = video;
        "application/ogg" = audio;
        "image/png" = image;
        "application/x-httpd-php" = text;
        "application/vnd.ms-powerpoint" = office;
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = office;
        "application/vnd.rar" = archive;
        "application/rtf" = text;
        "application/x-sh" = text;
        "image/svg+xml" = image;
        "application/x-tar" = archive;
        "image/tiff" = image;
        "video/mp2t" = video;
        "text/plain" = text;
        "audio/wav" = audio;
        "audio/webm" = audio;
        "video/webm" = video;
        "image/webp" = image;
        "application/xhtml+xml" = html;
        "application/vnd.ms-excel" = office;
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = office;
        "application/xml" = text;
        "application/zip" = archive;
        "video/3gpp" = video;
        "audio/3gpp" = audio;
        "video/3gpp2" = video;
        "audio/3gpp2" = audio;
        "application/x-7z-compressed" = archive;
        "text/x-diff" = diff;
        "text/x-patch" = diff;
        "application/pdf" = [
          ''${pkgs.poppler_utils}/bin/pdftoppm -jpeg -f 1 -singlefile -- "$TVIEW_FILE" | ${pkgs.chafa}/bin/chafa -s "${"\${TVIEW_WIDTH}"}x${"\${TVIEW_HEIGHT}"}" $([ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] || ${pkgs.toybox}/bin/printf -- "-f sixels")''
        ];
        "application/x-bittorrent" = [ ''${pkgs.transmission_4}/bin/transmission-show -- "$TVIEW_FILE"'' ];

        "inode/directory" = [
          ''${pkgs.coreutils}/bin/ls --color --group-directories-first -w "$TVIEW_WIDTH" -- "$TVIEW_FILE"''
        ];

        "application/octet-stream" = [
          ''${pkgs.exiftool}/bin/exiftool -- "$TVIEW_FILE"''
          ''${pkgs.file}/bin/file -- "$TVIEW_FILE"''
          ''${pkgs.toybox}/bin/cat -- "$TVIEW_FILE"''
        ];

        "text/markdown" = [
          ''${pkgs.glow}/bin/glow -w "$TVIEW_WIDTH" -- "$TVIEW_FILE"''
          ''${pkgs.mdcat}/bin/mdcat --columns "$TVIEW_WIDTH" -- "$TVIEW_FILE"''
        ];
      };
  };
}
