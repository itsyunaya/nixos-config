{ ... }: {
	programs = {
		eza = {
			enable = true;
			enableZshIntegration = true;
		};

		yazi = {
			enable = true;
			shellWrapperName = "y";

			enableZshIntegration = true;
		};

		direnv = {
			enable = true;

			enableZshIntegration = true;

			nix-direnv.enable = true;
		};
	};
}
