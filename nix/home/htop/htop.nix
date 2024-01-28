{ pkgs, ... }:
{
	config.programs.htop.package = pkgs.htop-vim;
}
