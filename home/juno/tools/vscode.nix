{ pkgs, ... }: {
	programs.vscode = {
		enable = true;

		profiles.default.extensions = with pkgs.vscode-extensions; [
			mvllow.rose-pine
			jnoortheen.nix-ide
			haskell.haskell
			justusadam.language-haskell
			mkhl.direnv
		];

		profiles.default.userSettings = {
			"workbench.colorTheme" = "Rosé Pine";
			"editor.tabSize" = 4;
			"haskell.manageHLS" = "PATH";
			# i dont like slop in my code :/
			"chat.disableAIFeatures" = true;
		};
	};
}
