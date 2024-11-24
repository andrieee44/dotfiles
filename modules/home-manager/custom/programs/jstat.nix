{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "98106b8f1b3b378e5df5d6590a17f20fd0ec8e4d";
        hash = "sha256-NFva/zrL2mu90rl30V5fgm4tk71UTYLE06mevG4r8yg=";
      };
    in
    pkgs.buildGoModule {
      name = "jstat";
      vendorHash = "sha256-CnKyHcOb8ZwCk2BUyIsdoOb0gZQ4iDauYtVU3Y+ms2s=";
      sourcePath = "${src.name}/cmd/jstat";
      src = src;
    };
}
