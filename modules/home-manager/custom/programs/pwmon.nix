{ pkgs, ... }:
{
  custom.programs.pwmon.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pwmon";
        rev = "28140f90a6f77e18c6005a45d49095f785187390";
        hash = "sha256-KCLzriEK4PCHewGEZjeL2TxsWr33htzZFTWRHTuoltY=";
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
