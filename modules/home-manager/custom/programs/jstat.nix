{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "158c349f9eef3515f53674031a4bdcfe048e6894";
        hash = "sha256-7TlTMSm7sDC8JI5DOoY/k4f7KWY9UJ+4l3BHG75ETEk=";
      };
    in
    pkgs.buildGoModule {
      name = "jstat";
      vendorHash = "sha256-H1bC3sJfUxL7wVVh5mjASHDkcV2dGsdui8NuEhgvNSc=";
      sourcePath = "${src.name}/cmd/jstat";
      src = src;
    };
}
