# recreation of import-tree's basic functionality
# since i dont need most of what it offers
{ lib, ... }: let
	inherit (lib) hasInfix hasSuffix;
	inherit (builtins) filter;
in
	dir: let
		dirPath =
			if builtins.isAttrs dir && dir ? outPath
			then dir.outPath
			else dir;

		files = filter
		(file: let
				path = toString file;
			in
				hasSuffix ".nix" path && !hasInfix "/_" path)
		(lib.filesystem.listFilesRecursive dirPath);
	in {
		imports = files;
	}
