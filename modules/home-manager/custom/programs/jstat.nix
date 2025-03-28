{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "cb16fd9049ad4af8740354ae789d6543fd95006b";
        hash = "sha256-UVqsNyWo/c1qETqY07hNO4tDY2ZgAcppwee0IJky6GE=";
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
