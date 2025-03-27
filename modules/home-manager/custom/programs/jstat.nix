{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "39bf9ffd8a6c738b5d649d725ea2ca26070b81f2";
        hash = "sha256-VQG+SMvjN8VDn4r/CdHD2DhpwGZg6aFz2wTG3LNtUt8=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-qjtTXHW4PIWUGWF1a8qZm8Uiwhw2Q577CsBe8p63L8k=";
      sourcePath = "${src.name}/cmd/jstat";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';
    };
}
