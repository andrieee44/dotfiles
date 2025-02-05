{ pkgs, ... }:
{
  custom.programs.pass-data.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pass-data";
        rev = "28107d254657fb2da766425d80638a03b2a5c34d";
        hash = "sha256-wm1cnVesy4faTiCLDtPVuSBQH1RsRBZYTc0bxRn4Cos=";
      };
    in
    pkgs.stdenv.mkDerivation {
      inherit src;
      name = "pass-data";

      installPhase =
        let
          toybox = "${pkgs.toybox}/bin";
          progPath = "${"\${out}"}/lib/password-store/extensions/data.bash";
        in
        ''
          runHook preInstall
          mkdir -p "${"\${out}"}/share/man/man1" "${"\${out}"}/lib/password-store/extensions"
          gzip -c "${src}/pass-data.1" > "${"\${out}"}/share/man/man1/pass-data.1.gz"
          cp "${src}/data.bash" "${progPath}"

          substituteInPlace "${progPath}" \
          	--replace-fail "echo" "${toybox}/echo" \
          	--replace-fail "mkdir" "${toybox}/mkdir" \
          	--replace-fail "cp" "${toybox}/cp" \
          	--replace-fail "tar " "${pkgs.gnutar}/bin/tar " \
          	--replace-fail "gzip" "${pkgs.gzip}/bin/gzip"

          runHook postInstall
        '';
    };
}
