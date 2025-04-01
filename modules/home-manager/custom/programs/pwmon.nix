{ pkgs, ... }:
{
  custom.programs.pwmon.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pwmon";
        rev = "aeccd11966352ccf5857eb3b206fc1147546e4bc";
        hash = "sha256-Nf+WLzDazCWeSvNJuIeW6mvjsIG9SgdebEb1Q+OekVM=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "pwmon";
      vendorHash = null;
      sourcePath = "${src.name}/cmd/notifydbus";

      postPatch = ''
        substituteInPlace "./pkg/pwmon.go" \
        	--replace-fail "wpctl" "${pkgs.wireplumber}/bin/wpctl" \
          	--replace-fail "pactl" "${pkgs.pulseaudio}/bin/pactl"
      '';

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/pwmon.1" > "${"\${out}"}/share/man/man1/pwmon.1.gz"
      '';
    };
}
