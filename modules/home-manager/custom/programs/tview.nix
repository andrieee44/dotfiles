{ config, pkgs, ... }:
{
  custom.programs.tview = {
    package =
      let
        src = pkgs.fetchFromGitHub {
          owner = "andrieee44";
          repo = "tview";
          rev = "f42d1f7583db2212d3d503541f433f98b1079058";
          hash = "sha256-LZQxztxBFfiuCr3bQepyLZ6wkMKDzh0s6OckRyJ7UFM=";
        };
      in
      pkgs.buildGoModule {
        name = "tview";
        vendorHash = "sha256-g4w2RmA7VTL+ittKdV0867MbfAHKkYpgpJXeHppTbfM=";
        src = src;

        postInstall = ''
          mkdir -p $out/share/man/man1
          gzip -c ${src}/tview.1 > $out/share/man/man1/tview.1.gz
        '';
      };

    settings =
      let
        audio = [ ''${pkgs.mediainfo}/bin/mediainfo -- "$TVIEW_FILE"'' ];
        archive = [ ''${pkgs.atool}/bin/atool -l -- "$TVIEW_FILE"'' ];
        office = [ ''${pkgs.libreoffice}/bin/libreoffice --cat "$TVIEW_FILE"'' ];

        video = [
          ''${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$TVIEW_FILE" -s 0 -o /dev/stdout | ${pkgs.chafa}/bin/chafa -s "${"\${TVIEW_COLUMNS}"}x${"\${TVIEW_ROWS}"}" $([ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] || ${pkgs.toybox}/bin/printf -- "-f sixels")''
          ''${pkgs.mediainfo}/bin/mediainfo -- "$TVIEW_FILE"''
        ];

        image = [
          ''${pkgs.chafa}/bin/chafa -s "${"\${TVIEW_COLUMNS}"}x${"\${TVIEW_ROWS}"}" $([ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] || ${pkgs.toybox}/bin/printf -- "-f sixels") "$TVIEW_FILE"''
          ''${pkgs.imagemagick}/bin/magick "$TVIEW_FILE" jpg:- | ${pkgs.chafa}/bin/chafa -s "${"\${TVIEW_COLUMNS}"}x${"\${TVIEW_ROWS}"}" $([ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] || ${pkgs.toybox}/bin/printf -- "-f sixels")''
          ''${pkgs.mediainfo}/bin/mediainfo -- "$TVIEW_FILE"''
        ];

        jq = [
          ''${pkgs.jaq}/bin/jaq -C always . "$TVIEW_FILE"''
          ''${pkgs.jq}/bin/jq -C . "$TVIEW_FILE"''
        ];

        text = [
          ''${config.programs.bat.package}/bin/bat --color always --paging never --terminal-width "$TVIEW_COLUMNS" -- "$TVIEW_FILE"''
          ''${pkgs.sourceHighlight}/bin/source-highlight --failsafe -i "$TVIEW_FILE"''
          ''${pkgs.toybox}/bin/cat -- "$TVIEW_FILE"''
        ];

        html = [
          ''${pkgs.elinks}/bin/elinks -dump 1 -no-references -no-numbering -dump-width "$TVIEW_COLUMNS" "$TVIEW_FILE"''
          ''${pkgs.lynx}/bin/lynx -dump -nonumbers -nolist -width "$TVIEW_COLUMNS" -- "$TVIEW_FILE"''
          ''${pkgs.w3m}/bin/w3m -dump "$TVIEW_FILE"''
        ];

        diff = [
          ''${pkgs.delta}/bin/delta < "$TVIEW_FILE"''
          ''${pkgs.diff-so-fancy}/bin/diff-so-fancy < "$TVIEW_FILE"''
          ''${pkgs.colordiff}/bin/colordiff < "$TVIEW_FILE"''
        ];
      in
      {
        "application/gzip" = archive;
        "application/java-archive" = archive;
        "application/json" = jq;
        "application/ld+json" = jq;
        "application/msword" = office;
        "application/ogg" = audio;
        "application/rtf" = text;
        "application/vnd.ms-excel" = office;
        "application/vnd.ms-powerpoint" = office;
        "application/vnd.oasis.opendocument.presentation" = office;
        "application/vnd.oasis.opendocument.spreadsheet" = office;
        "application/vnd.oasis.opendocument.text" = office;
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = office;
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = office;
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = office;
        "application/vnd.rar" = archive;
        "application/x-7z-compressed" = archive;
        "application/x-abiword" = office;
        "application/x-bittorrent" = [ ''${pkgs.transmission_4}/bin/transmission-show -- "$tview_file"'' ];
        "application/x-bzip" = archive;
        "application/x-bzip2" = archive;
        "application/x-cdf" = audio;
        "application/x-csh" = text;
        "application/x-freearc" = archive;
        "application/x-gzip" = archive;
        "application/x-httpd-php" = text;
        "application/x-sh" = text;
        "application/x-tar" = archive;
        "application/xhtml+xml" = html;
        "application/xml" = text;
        "application/zip" = archive;
        "audio/3gpp" = audio;
        "audio/3gpp2" = audio;
        "audio/aac" = audio;
        "audio/midi" = audio;
        "audio/mpeg" = audio;
        "audio/ogg" = audio;
        "audio/wav" = audio;
        "audio/webm" = audio;
        "audio/x-midi" = audio;
        "image/apng" = image;
        "image/avif" = image;
        "image/bmp" = image;
        "image/gif" = image;
        "image/jpeg" = image;
        "image/png" = image;
        "image/svg+xml" = image;
        "image/tiff" = image;
        "image/vnd.microsoft.icon" = image;
        "image/webp" = image;
        "text/css" = text;
        "text/csv" = text;
        "text/html" = html;
        "text/javascript" = text;
        "text/plain" = text;
        "text/x-diff" = diff;
        "text/x-patch" = diff;
        "video/3gpp" = video;
        "video/3gpp2" = video;
        "video/mp2t" = video;
        "video/mp4" = video;
        "video/mpeg" = video;
        "video/ogg" = video;
        "video/webm" = video;
        "video/x-matroska" = video;
        "video/x-msvideo" = video;

        "application/octet-stream" = [
          ''${pkgs.exiftool}/bin/exiftool -- "$TVIEW_FILE"''
          ''${pkgs.file}/bin/file -- "$TVIEW_FILE"''
          ''${pkgs.toybox}/bin/cat -- "$TVIEW_FILE"''
        ];

        "application/pdf" = [
          ''${pkgs.poppler_utils}/bin/pdftoppm -jpeg -f 1 -singlefile -- "$TVIEW_FILE" | ${pkgs.chafa}/bin/chafa -s "${"\${TVIEW_COLUMNS}"}x${"\${TVIEW_ROWS}"}" $([ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] || ${pkgs.toybox}/bin/printf -- "-f sixels")''
        ];

        "inode/directory" = [
          ''${pkgs.coreutils}/bin/ls --color --group-directories-first -w "$TVIEW_COLUMNS" -- "$TVIEW_FILE"''
        ];

        "text/markdown" = [
          ''${pkgs.glow}/bin/glow -w "$TVIEW_COLUMNS" -- "$TVIEW_FILE"''
          ''${pkgs.mdcat}/bin/mdcat --columns "$TVIEW_COLUMNS" -- "$TVIEW_FILE"''
        ];
      };
  };
}
