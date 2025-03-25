{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "a879fcf40f9dbd7da1d4947b28dcf1df173257de";
        hash = "sha256-eF2wyBxZ5NhiYdACEXWdnXUfyw5K8b9zRRFzkTIqjOY=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-1KL4SbEC7vPxjlsuHS0ZldWerc/V/S8MkIWjCdT+CCo=";
      sourcePath = "${src.name}/cmd/jstat";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';
    };
}
