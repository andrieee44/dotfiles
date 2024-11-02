{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "ba5f1f8794b4e1151da57df89a0cfbb86d7fd977";
        hash = "sha256-EphrJ2Gx4zW5RqC+gdnaffp4jZwlkozWQOR/ItMk4wk=";
      };
    in
    pkgs.buildGoModule {
      name = "jstat";
      vendorHash = "sha256-fKQUVEwpHZPX3Wp1s3//U7fvLoDeY2Nt6EyPr+EUFME=";
      sourcePath = "${src.name}/cmd/jstat";
      src = src;
    };
}
