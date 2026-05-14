{ theme, ... }:

{
	services.dunst = {
		enable = true;

		settings = {
			global = {
				frame_color = "#${theme.colours.accent-pink}";
				separator_color = "frame";
				highlight = "#${theme.colours.accent-pink}";
				transparency = 20;
				offset = 20;
				font = "JetbrainsMonoNL Nerd Font";
				corner_radius = 7;
			};

			urgency_low = {
				background = "#24273a";
				foreground = "#cad3f5";
			};

			urgency_normal = {
				background = "#24273a";
				foreground = "#cad3f5";
			};

			urgency_critical = {
				background = "#24273a";
				foreground = "#cad3f5";
				frame_color = "#f5a97f";
			};
		};
	};
}
