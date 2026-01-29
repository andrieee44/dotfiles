{ config, ... }:
{
  programs.texlive.extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };

  xdg.configFile."latexmk/latexmkrc" = {
    enable = config.programs.texlive.enable;

    text = ''
      $ENV{'TEXMFHOME'} = "${config.xdg.dataHome}/texlive";
      $ENV{'TEXMFCONFIG'} = "${config.xdg.configHome}/texlive";
      $ENV{'TEXMFVAR'} = "${config.xdg.cacheHome}/texlive";

      $out_dir = 'build';
      $aux_dir = $out_dir;
      $log_file = "$out_dir/latexmk.log";
      $pdf_mode = 5;
    '';
  };
}
