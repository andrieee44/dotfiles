{ pkgs, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "eda11592eec06d3a8db44ea5a8c46bd71edff0db";
        hash = "sha256-Mo427LBMs/XOHinTDS6tw5eX7xO2diFiKCnQPnNeOnM=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-kPaQjvV7zOIXcJu2wTvici9eFM8sUfM08geCJTou5es=";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        # gzip -c "${src}/notifydbus.1" > "${"\${out}"}/share/man/man1/notifydbus.1.gz"
      '';
    };
}
