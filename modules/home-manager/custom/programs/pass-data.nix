{ config, pkgs, ... }:
{
  custom.programs.pass-data.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pass-data";
        rev = "772f9927bc4fb09d9a43fd635903f5a925c95210";
        hash = "sha256-MCJl6Njf5QddRmCjs4OUejzAE8dKKuPkKmt1kiy0My4=";
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
