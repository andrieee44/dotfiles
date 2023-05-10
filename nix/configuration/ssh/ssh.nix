{ config, ... }:
{
	config.programs.ssh = {
		startAgent = true;
		agentTimeout = null;

		extraConfig = ''
			AddKeysToAgent yes
		'';
	};
}
