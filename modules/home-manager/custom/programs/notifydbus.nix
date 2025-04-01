{ pkgs, lib, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "12362664a6f7cbf0805867f66def93df4dde4c7c";
        hash = "sha256-evKz7+w6HtwYFLzZkwr8AcyAvz7s9Wk9O6RLWZ6JOJ0=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-ZRqAIDn/+aQGr69qTWUTIXNonM0tOZE2NK6a9ocQpkM=";
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
