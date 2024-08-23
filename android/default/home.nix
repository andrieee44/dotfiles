{ pkgs, stateVersion, ... }:
{
	home = {
		stateVersion = stateVersion;

		packages = with pkgs; [
			openssh
		];
	};

	programs = {
		git.enable = true;
		ssh.enable = true;
		go.enable = true;
	};
}