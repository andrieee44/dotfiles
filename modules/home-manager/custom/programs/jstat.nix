{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "43059a8cb597a1463ea9dfe1d1ac08620127c267";
        hash = "sha256-rOhwkzP13s3nq77L/QW+RdRi+eFZ+TkJZ3f3BaFKd/w=";
      };
    in
    pkgs.buildGoModule {
      name = "jstat";
      vendorHash = "sha256-H1bC3sJfUxL7wVVh5mjASHDkcV2dGsdui8NuEhgvNSc=";
      sourcePath = "${src.name}/cmd/jstat";
      src = src;
    };
}
