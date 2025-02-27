{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "3f23987d091f35ed62d8e57e9aff5ceca6b0eea7";
        hash = "sha256-KJEc43fbE51GrzefmJjf18KWYoLpEB9K68I/4frQP60=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-5Vg7zM6E12G6mvf9uc3PXZsUbxCjH1z9mt37CD5ALak=";
      sourcePath = "${src.name}/cmd/jstat";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';
    };
}
