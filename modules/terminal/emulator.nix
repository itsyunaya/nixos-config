{ osConfig, lib, ... }: let
	shell = osConfig.itsyunaya-nix.shell;
	shellBinaries = {
		zsh = "/run/current-system/sw/bin/zsh";
		nushell = "/run/current-system/sw/bin/nu";
	};
in {
	config = lib.mkMerge [
		(lib.mkIf (osConfig.itsyunaya-nix.terminal == "kitty") {
				programs.kitty = {
					enable = true;
					font.name = "JetBrainsMono Nerd Font";

					settings = {
						shell = shellBinaries.${shell};
						cursor_trail = "1";
						enable_audio_bell = "no";
						window_margin_width = "8";
						background_opacity = "0.7";
					};
				};
			})

		(lib.mkIf (osConfig.itsyunaya-nix.terminal == "ghostty") {
				programs.ghostty = {
					enable = true;

					settings = {
						font-family = "JetBrainsMono Nerd Font";
						command = shellBinaries.${shell};

						cursor-style-blink = true;
						app-notifications = "no-clipboard-copy";

						background = "111111";
						window-padding-x = 8;
						window-padding-y = 8;
						background-opacity = 0.7;
					};
				};
			})
	];
}
