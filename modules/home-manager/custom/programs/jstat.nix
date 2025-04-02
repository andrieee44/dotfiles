{ pkgs, lib, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "1e012f923a670d12b1e3c8db22e80dbd66946f59";
        hash = "sha256-3tADAiqWA25HeqmSimfUlsO0HX1i8sla7fMv5fYcTOE=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-BInS2/XIyGFM3Tb0nzzlRbaZEfAvjoNbzzSFPbF1tk0=";
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
