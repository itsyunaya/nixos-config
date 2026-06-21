{ osConfig, ... }: let
	shell = osConfig.juno-cfg.sh.shell;
in {
	programs = {
		eza = {
			enable = shell == "zsh";
			enableZshIntegration = shell == "zsh";
		};

		yazi = {
			enable = true;
			shellWrapperName = "y";

			enableZshIntegration = shell == "zsh";
			enableNushellIntegration = shell == "nushell";
		};

		direnv = {
			enable = true;

			enableZshIntegration = shell == "zsh";
			enableNushellIntegration = shell == "nushell";

			nix-direnv.enable = true;
			/*
			  stdlib = builtins.readFile (pkgs.runCommand "devenv-direnvrc" {} ''
				${pkgs.devenv}/bin/devenv direnvrc > $out
			'');
			*/
		};
	};
}
