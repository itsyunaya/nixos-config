{ osConfig, pkgs, ... }:

let
	shell = osConfig.itsyunaya-nix.shell;
in {
	programs.eza = {
		enable = osConfig.itsyunaya-nix.shell == "zsh";

		enableZshIntegration = shell == "zsh";
		#enableNushellIntegration = shell == "nushell";
	};
	
	programs.git = {
		enable = true;

		settings = {
			user.name = "itsyunaya";
			# dont use actual email cuz i dont wanna dox myself yk
			user.email = "40719746+itsyunaya@users.noreply.github.com";
			user.signingKey = "198EA594738FED19";
			commit.gpgsign = true;
			tag.gpgSign = true;
			init.defaultBranch = "main";
		};
	};

	programs.yazi = {
		enable = true;
		shellWrapperName = "y";

		enableZshIntegration = shell == "zsh";
		enableNushellIntegration = shell == "nushell";
	};

	programs.direnv = {
		enable = true;

		enableZshIntegration = shell == "zsh";
        enableNushellIntegration = shell == "nushell";

		nix-direnv.enable = true;
		stdlib = builtins.readFile (pkgs.runCommand "devenv-direnvrc" {} ''
			${pkgs.devenv}/bin/devenv direnvrc > $out
		'');
	};
}
