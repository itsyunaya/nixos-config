{ theme, config, lib, ... }:

let
	src = "${toString ./.}/../../../assets/wallpapers/clouds.jpg";
in {
	config = lib.mkIf (config.itsyunaya-nix.lock-app == "hyprlock") {
		programs.hyprlock = {
			enable = true;

			# ported from https://github.com/LoneWolf4713/seraphic.dotfiles/blob/b87fe836927ea11b42c93192dec974d6872b94b3/dotfiles/hypr/hyprlock.conf
			settings = {
				background = {
					monitor = "";
					path = "${src}";

					blur_size = 5;
					blur_passes = 1;
					noise = 0.0117;
					contrast = 1.3000;
					brightness = 0.8000;
					vibrancy = 0.2100;
					vibrancy_darkness = 0.0;
                };

                input-field = {
                	monitor = "";
                	size = "250, 50";
                	outline_thickness = 3;
					dots_size = 0.2;
                	dots_spacing = 0.35;
                	dots_center = true;
                	outer_color = "rgba(${theme.colours.accent-pink}ff)";
                	inner_color = "rgba(${theme.colours.bg}ff)";
                	font_color = "rgba(ffffffff)";
                	#fade_on_empty = true;
                	placeholder_text = "<i>Password...</i>";
                	hide_input = false;
                	position = "0, 60";
                	halign = "center";
                	valign = "bottom";
                };

                label = [
                # hours
                {
                    monitor = "";
                    text = ''cmd[update:1000] echo "<b><big> $(date +"%H") </big></b>"'';
                    color = "rgba(ffffffff)";
                    font_size = 128;
                    font_family = "IBM Plex Sans Medium 10";
                    position = "0, 160";
                    halign = "center";
                    valign = "center";
                }
                # minutes
                {
                    monitor = "";
                    text = ''cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"'';
                    color = "rgba(ffffffff)";
                    font_size = 128;
                    font_family = "IBM Plex Sans Medium 10";
                    position = "0, 0";
                    halign = "center";
                    valign = "center";
                }
                # date (day/month)
                {
                    monitor = "";
                    text = ''cmd[update:1000] echo "<b><big> $(date +"%d %b") </big></b>"'';
                    color = "rgba(ffffffff)";
                    font_size = 16;
                    font_family = "IBM Plex Sans Medium 10";
                    position = "0, -100";
                    halign = "center";
                    valign = "center";
                }
                # weekday
                {
                    monitor = "";
                    text = ''cmd[update:1000] echo "<b><big> $(date +"%A") </big></b>"'';
                    color = "rgba(ffffffff)";
                    font_size = 16;
                    font_family = "IBM Plex Sans Medium 10";
                    position = "0, -120";
                    halign = "center";
                    valign = "center";
                }
				];

			};
		};
	};
}