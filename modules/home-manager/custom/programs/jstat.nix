{ pkgs, lib, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "203155fadb651b0d9f892de935a1e4002cb8f110";
        hash = "sha256-4NfJnnDZ246WR+R0Xdr5g9kwwsLSFjCp5NGlNo3erj0=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-PixcmYZTlHNSOYoRpxaVMoy7TF/VdJvwBLlM89x1pVo=";
      sourcePath = "${src.name}/cmd/jstat";
      nativeBuildInputs = [ pkgs.makeWrapper ];

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';

      postFixup = ''
        wrapProgram "${"\${out}"}/bin/jstat" \
        	--set PATH ${
           lib.makeBinPath (
             with pkgs;
             [
               wireplumber
               pulseaudio
             ]
           )
         }
      '';
    };
}
