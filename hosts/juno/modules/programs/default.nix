{ pkgs, ... }: {
	programs = {
		zsh.enable = true;

		#appimage.enable = true;
		#appimage.binfmt = true;

		hyprland.enable = true;
		#mango.enable = true;

		anime-game-launcher.enable = true;
		steam.enable = true;

		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryPackage = pkgs.pinentry-qt;
		};
	};
}
