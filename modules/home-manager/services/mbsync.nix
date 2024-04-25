{ pkgs, ... }:
{
	services.mbsync = {
		frequency = "*:0/15";
		postExec = "${pkgs.notmuch}/bin/notmuch new";
	};
}
