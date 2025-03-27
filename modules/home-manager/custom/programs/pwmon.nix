{ pkgs, ... }:
{
  custom.programs.pwmon.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pwmon";
        rev = "7a83ea3c7b8a478566ad2411040c8a8fc8bfb5ed";
        hash = "sha256-gwfmYsrk181w/ySkOrxz2gAZ3IvUrKkjy+fwvuoxAFw=";
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
