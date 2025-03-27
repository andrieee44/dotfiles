{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "5ec8ca5713b03868f6a0459c110c4ca31e2c1691";
        hash = "sha256-s+1YOZ3UnXFL86/gh2dpoYNzs8OXUqiD8kjp/muxjC4=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-EyEVlO3ZZpkK+Xic6hQeS9UvjGBCUQ4VUzrvIqwtNdM=";
      sourcePath = "${src.name}/cmd/jstat";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';
    };
}
