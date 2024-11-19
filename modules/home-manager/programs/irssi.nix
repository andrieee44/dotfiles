{ config, ... }:
{
  programs.irssi.extraConfig = ''
    dcc = {
    	dcc_download_path = "${config.xdg.userDirs.download}";
    	dcc_upload_path = "${config.xdg.userDirs.publicShare}";
    };

    lookandfeel = {
    	timestamp_format = "%l:%M %p";
    	timestamp_format_alt = "%b %e %Y (%a) %l:%M %p";
    };

    misc = {
    	settings_autosave = "no";
    };
  '';
}
