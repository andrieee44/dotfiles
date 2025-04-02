{ pkgs, lib, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "ddc024bf5f74ed1848c94c36b7063d17327e611e";
        hash = "sha256-Jfm1v4OFmtdATZPJnEvRhjSgYAt25HcxTQSXE43a7ks=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-uZ/tvMk5ZFFUg4OzgW8Eo890SkhZsoao53P8o0Umcq8=";
      sourcePath = "${src.name}/cmd/notifydbus";
      nativeBuildInputs = [ pkgs.makeWrapper ];

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/notifydbus.1" > "${"\${out}"}/share/man/man1/notifydbus.1.gz"
      '';

      postFixup = ''
        wrapProgram "${"\${out}"}/bin/notifydbus" \
        	--set PATH ${
           lib.makeBinPath (
             with pkgs;
             [
               wireplumber
               pulseaudio
               ffmpeg
             ]
           )
         }
      '';
    };
}
