{ pkgs, ... }:
{
  custom.programs.lsbin.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "lsbin";
        rev = "009a4ac97674e6e2001b97c941ac8a799fb3f138";
        hash = "sha256-WsiQqPyfGrObdbnWOZbQYPW6OTJgFls6wkH1OiPY39M=";
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
