{ pkgs, ... }:
{
	programs.ssh.package = pkgs.openssh;
}