{ pkgs, lib, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "870e5617fa9eb79a6501ccffaef3a01bd343be72";
        hash = "sha256-dgC+1I7CNkHNRFs1KSlTaClweFmS+mQP0zNDplMrmGA=";
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
