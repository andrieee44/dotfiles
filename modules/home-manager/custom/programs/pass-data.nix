{ pkgs, ... }:
{
  custom.programs.pass-data.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pass-data";
        rev = "616e90dc710a3312419468176d3b2506bbafc816";
        hash = "sha256-XSKA7/XCAxjGdX12p+3hTBgXVcIPM6eW3VaMwEt3gC4=";
      };
    in
    pkgs.stdenv.mkDerivation {
      name = "pass-data";
      dontBuild = true;
      src = src;

      buildInputs = with pkgs; [
        diffutils
        gnutar
        gzip
      ];

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1" "${"\${out}"}/lib/password-store/extensions"
        gzip -c "${src}/pass-data.1" > "${"\${out}"}/share/man/man1/pass-data.1.gz"
        cp "${src}/data.bash" "${"\${out}"}/lib/password-store/extensions"
      '';
    };
}
