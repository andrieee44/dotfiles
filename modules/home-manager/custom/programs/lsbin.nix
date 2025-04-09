{ pkgs, ... }:
{
  custom.programs.lsbin.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "lsbin";
        rev = "f7fd610ddd701230234857869185515505c29149";
        hash = "sha256-k5Fv7NYPs1P1hZ+81z5dPU1OGWCSddcw4+2q3m+IcKQ=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "lsbin";
      vendorHash = "sha256-s8Hg8pTAFYtolY6rjJP7WylrXmXova834gPmQq7aBBE=";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/lsbin.1" > "${"\${out}"}/share/man/man1/lsbin.1.gz"
      '';
    };
}
