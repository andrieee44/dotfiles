{ ... }:
{
	programs.fzf = {
		tmux = {
			enableShellIntegration = true;
			shellIntegrationOptions = [
				"-p '45%,60%'"
				"--border=sharp"
			];
		};

		defaultOptions = [
			"--exact"
			"--reverse"
			"--info inline"
			"--header-first"
			"--header 'Search file:'"
			"--tabstop 4"
			"--no-mouse"
			"--preview-window border-left,wrap"
		];
	};
}
