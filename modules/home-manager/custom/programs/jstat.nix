{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "007bb063b974c5c2fbd34b70d687bf6a03015b5b";
        hash = "sha256-yxKhek0VM2z+WVzzu2KW6yC8YsCLjXoS5AFcEM3EDwE=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-RQBLkstNwtpyHDTCJZ0Xq1/iCrhltTJqzo9NM2qkoco=";
      sourcePath = "${src.name}/cmd/jstat";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';
    };
}
