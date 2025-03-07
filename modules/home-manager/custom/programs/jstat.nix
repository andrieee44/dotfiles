{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "edee819df8a850d5a20c28b12482b86393f8184d";
        hash = "sha256-guhrj22kacIPZ+f0qXHqStLmtPbS6tvZaxGu9suK5j8=";
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
