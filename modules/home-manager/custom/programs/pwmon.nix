{ pkgs, ... }:
{
  custom.programs.pwmon.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pwmon";
        rev = "71b5c824976f3a0e3bb9c081566899b3eac05e5f";
        hash = "sha256-gAbpL+ZNRV7L35ZSP20E1KwQJKUNVkwyHeGodqwwDeU=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "pwmon";
      vendorHash = null;

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/pwmon.1" > "${"\${out}"}/share/man/man1/pwmon.1.gz"
      '';
    };
}
