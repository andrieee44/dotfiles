{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "bf95341fb4f9cbc052c830ce3bf6956ad283ab17";
        hash = "sha256-U8lGbV4muLirU4B+dSwDfBQgbXjHxDwVOLELlIlnaqQ=";
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
