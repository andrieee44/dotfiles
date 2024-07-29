{ stateVersion, ... }:
{
	home.stateVersion = stateVersion;
	
	programs = {
		git.enable = true;
	};
}