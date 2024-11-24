{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "47d966e0fd5497b39a4127db79282e7259f3a6af";
        hash = "sha256-Qva1/cJ+e3elK46jGueN5huoXzHCBANPwNrTEp0aPZo=";
      };
    in
    pkgs.buildGoModule {
      name = "jstat";
      vendorHash = "sha256-fKQUVEwpHZPX3Wp1s3//U7fvLoDeY2Nt6EyPr+EUFME=";
      sourcePath = "${src.name}/cmd/jstat";
      src = src;
    };
}
