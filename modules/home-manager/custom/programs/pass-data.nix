{ pkgs, ... }:
{
  custom.programs.pass-data.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pass-data";
        rev = "6423f55a3ca39acf2da428892dfa3081f3dd9264";
        hash = "sha256-OvZA9yJWsiv/jgkWdg5lVv8MpPvHUaPmFZ6U7FBECEU=";
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
