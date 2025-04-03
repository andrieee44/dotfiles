{ pkgs, ... }:
{
  custom.programs.lsbin.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "lsbin";
        rev = "69a3bd55a5592f8ba84d5ab56a61271f7b63b8e7";
        hash = "sha256-5LMS4wftTI8xvtO+MS54d63qXvSy6sTwcwSkgEzxcws=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "lsbin";
      vendorHash = "sha256-qy4wFPjUb3nxiujHUQ6LiKkmJ+EdLVngm9y+tnaJefU=";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/lsbin.1" > "${"\${out}"}/share/man/man1/lsbin.1.gz"
      '';
    };
}
