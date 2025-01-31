{ pkgs, ... }:
{
  custom.programs.pass-data.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pass-data";
        rev = "be1921a9a14b4fc9084234e55a69251076f49648";
        hash = "sha256-jiRxAtH+odfp8b52I1pIaN29uE2Gff/X4PpqVN8u1D0=";
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
