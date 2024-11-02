{ pkgs, ... }:
{
  programs.mpv = {
    scriptOpts.thumbfast.network = true;

    bindings = {
      h = "seek -5";
      j = "seek -60";
      k = "seek 60";
      l = "seek 5";
      H = "add volume -5";
      J = "frame-back-step";
      K = "frame-step";
      L = "add volume 5";
      u = ''cycle-values loop-file "inf" "no"'';
    };

    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
    ];

    config = {
      osd-bar = false;
      border = false;
      video-sync = "display-resample";
    };
  };
}
