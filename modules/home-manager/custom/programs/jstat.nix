{ pkgs, lib, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "516734dd2e839dc3aa2667d639494ff49dfcee30";
        hash = "sha256-Mxx4ZChZnCG1CpH5YdEUPeDWkP27fixpr4qARqkw/EM=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-SnpcJUgCRCHIni3RGUcDTckeiNCBVQHsb1qpuovd5n0=";
      sourcePath = "${src.name}/cmd/jstat";
      nativeBuildInputs = [ pkgs.makeWrapper ];

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';

      postFixup = ''
        wrapProgram "${"\${out}"}/bin/jstat" \
        	--set PATH ${
           lib.makeBinPath (
             with pkgs;
             [
               wireplumber
               pulseaudio
             ]
           )
         }
      '';
    };
}
