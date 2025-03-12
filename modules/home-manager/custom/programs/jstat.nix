{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "0ce3200b932246f41ec0032a3501bf765414ab08";
        hash = "sha256-ppmnnR7t9QkUoWWOb8TC6oXRwhYmuTMGhCR1OitohzU=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-RQBLkstNwtpyHDTCJZ0Xq1/iCrhltTJqzo9NM2qkoco=";
      sourcePath = "${src.name}/cmd/jstat";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';
    };
}
