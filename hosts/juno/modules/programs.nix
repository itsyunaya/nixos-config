{ config, pkgs, self, ... }: {
	programs = {
		zsh.enable = config.juno-cfg.sh.shell == "zsh";

		appimage.enable = true;
		appimage.binfmt = true;

		hyprland.enable = true;
		#mango.enable = true;
		niri.enable = true;

		anime-game-launcher.enable = true;
		steam.enable = true;

		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryPackage = pkgs.pinentry-qt;
		};

		qtengine = {
			enable = true;

			config = {
				theme = {
					colorScheme = "${self}/assets/purple.colors";
					style = "darkly";

					font = {
						family = "Sans Serif";
						size = 11;
						weight = -1;
					};

					fontFixed = {
						family = "Sans Serif";
						size = 11;
						weight = -1;
					};
				};

				misc = {
					singleClickActivate = false;
					menusHaveIcons = false;
					shortcutsForContextMenus = true;
				};
			};
		};
	};

	# qtengine iconTheme does not work so i have to use this instead :c
	environment.etc."xdg/kdeglobals".text = ''
    	[Icons]
    	Theme=WhiteSur-dark
  	'';
}
