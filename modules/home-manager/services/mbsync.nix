{ pkgs, ... }:
{
	services.mbsync = {
		frequency = "*:00:00";
		postExec = "${pkgs.notmuch}/bin/notmuch new";
	};
}
