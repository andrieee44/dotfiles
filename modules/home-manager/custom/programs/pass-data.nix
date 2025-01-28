{ pkgs, ... }:
{
  custom.programs.pass-data.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pass-data";
        rev = "11e00a48a802d95d913fde80836e1210b69c272c";
        hash = "sha256-UFVJdBVCH+9oUVn0Mzptq/Xi3HOJ8DWjXnVmNUVyp9c=";
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
