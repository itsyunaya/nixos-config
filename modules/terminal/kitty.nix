{ ... }:

{
	programs.kitty = {
		enable = true;
		font.name = "JetBrainsMono Nerd Font";

		settings = {
			shell = "/run/current-system/sw/bin/zsh";
			cursor_trail = "1";
			enable_audio_bell = "no";
			window_margin_width = "8";
			background_opacity = "0.7";
		 };
	};
}
