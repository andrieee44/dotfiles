{ config, ... }:
{
	config.programs.ssh = {
		startAgent = true;
		agentTimeout = null;
	};
}
