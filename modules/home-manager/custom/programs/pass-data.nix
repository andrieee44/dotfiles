{ config, pkgs, ... }:
{
  custom.programs.pass-data.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pass-data";
        rev = "0308e1c4ed95208e2fc83333e03d902fafd51b9a";
        hash = "sha256-e0MjF6SXcIiqKTqGQp364h83A58Fgd1lOQX7h+n+/LI=";
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
          	--replace-fail "gzip" "${pkgs.gzip}/bin/gzip" \
          	--replace-fail "diff" "${pkgs.diffutils}/bin/diff" \
          	--replace-fail "which" "${pkgs.which}/bin/which" \
          	--replace-fail "/usr/bin/env bash" "${config.programs.bash.package}/bin/bash"

          runHook postInstall
        '';
    };
}
