{ pkgs, ... }:
{
  custom.programs.pwmon.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pwmon";
        rev = "217bb4627db0277ae8b3c41949abd94a9bf45825";
        hash = "sha256-cMroKbg5/uTrUl7+AgEq0l62FGFEIz2LLggZI6O257A=";
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
