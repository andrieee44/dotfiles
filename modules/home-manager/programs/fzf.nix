{ lib, ... }:
{
  programs.fzf.defaultOptions = lib.mkForce [
    "--exact"
    "--reverse"
    "--info inline"
    "--header-first"
    "--header 'Search file:'"
    "--tabstop 4"
    "--no-mouse"
    "--preview-window border-left,wrap"
  ];
}
