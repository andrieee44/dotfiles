lib: path:
	builtins.filter (file:
		lib.hasSuffix ".nix" file
	) (lib.filesystem.listFilesRecursive path)
