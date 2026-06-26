{ ... }: {
	programs.kitty = {
		enable = true;
		font.name = "JetBrainsMono Nerd Font";

		settings = {
			shell = "/run/current-system/sw/bin/zsh";
			cursor_trail = "1";
			enable_audio_bell = "no";
			window_margin_width = "8";
			background_opacity = "0.7";

			foreground = "#cad3f5";
			cursor = "#cad3f5";

			selection_foreground = "#24273a";
			selection_background = "#cad3f5";
			url_color = "#cad3f5";

			color0 = "#494d64";
			color1 = "#ed8796";
			color2 = "#a6da95";
			color3 = "#eed49f";
			color4 = "#8aadf4";
			color5 = "#c6a0f6";
			color6 = "#7dc4e4";
			color7 = "#cad3f5";
			color8 = "#5b6078";
			color9 = "#ee99a0";
			color10 = "#a6da95";
			color11 = "#f5a97f";
			color12 = "#8aadf4";
			color13 = "#c6a0f6";
			color14 = "#7dc4e4";
			color15 = "#cad3f5";
		};
	};
}
