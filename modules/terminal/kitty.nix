{ osConfig, ... }:

let
	shell = osConfig.itsyunaya-nix.shell;
	shellBinaries = {
		zsh = "/run/current-system/sw/bin/zsh";
		nushell = "/run/current-system/sw/bin/nu";
	};
in {
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
}
