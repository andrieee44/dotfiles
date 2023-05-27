{ config, ... }:
{
	config.security.sudo = {
		wheelNeedsPassword = false;
	};
}
