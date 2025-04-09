{ pkgs, lib, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "2f61cfe5a313d989947bd5e321cdd775b6c997d7";
        hash = "sha256-FRFOZPoIvarWyTGoOgEAU/dzBxwnx0OtkCndQp3TXZs=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-OfDqjLRLqpKEaS6+yDDHGiPjw9KkkpjvSSLVssbfhJ0=";
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
