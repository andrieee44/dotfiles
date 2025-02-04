{ pkgs, ... }:
{
  custom.programs.pass-data.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pass-data";
        rev = "1b569c7575f82933559685be9700863e90c3d347";
        hash = "sha256-pNmOo/lr0SWqhCGicVuoIj5ohQpU7PE5tJqTTDBwOcQ=";
      };
    in
    pkgs.stdenv.mkDerivation {
      name = "pass-data";
      src = src;

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
