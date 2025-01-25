{ pkgs, ... }:
{
  custom.programs.pass-data.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pass-data";
        rev = "f822ac764cbdee4ba0645673de09f8644c3410e4";
        hash = "sha256-XhxknQ+sNItddy0rsPzG7+mEfV2QdRndDPl0bC8oJCc=";
      };
    in
    pkgs.stdenv.mkDerivation {
      name = "pass-data";
      dontBuild = true;
      src = src;

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1" "${"\${out}"}/lib/password-store/extensions"
        gzip -c "${src}/pass-data.1" > "${"\${out}"}/share/man/man1/pass-data.1.gz"
        cp "${src}/data.bash" "${"\${out}"}/lib/password-store/extensions"
      '';
    };
}
