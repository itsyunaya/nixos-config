{
	osConfig,
	lib,
	theme,
	inputs,
	pkgs,
	...
}: {
	config =
		lib.mkIf (osConfig.itsyunaya-nix.compositor == "hyprland") {
			wayland.windowManager.hyprland = {
				enable = true;
				package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
				#portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

				configType = "hyprlang";

				settings = {
					exec-once = [
						"waybar"
						"awww-daemon"
						"awww img ${theme.wallpaper}"
						"mpd-mpris"
						"yams"
						"musicpresence"
						"fcitx5"
						"anyrun daemon"
						"playerctld"
						"xwl-notifier"
					];

					monitor = [
						"DP-3, 2560x1440@144, 1920x0, 1.25"
						"DP-2, 1920x1080@60, 0x0, 1"
					];

					general = {
						gaps_in = "3";
						gaps_out = "7";

						border_size = "2";

						"col.active_border" = "rgba(${theme.colours.accent-pink}ee) rgba(${theme.colours.accent-purple}ee) 45deg";
						"col.inactive_border" = "rgba(${theme.colours.bg-lighter}aa)";

						layout = "dwindle";
					};

					decoration = {
						rounding = "10";
						active_opacity = "1.0";
						inactive_opacity = "1.0";

						shadow = {
							enabled = true;
							range = "4";
							render_power = "3";
							color = "rgba(1a1a1aee)";
						};

						blur = {
							enabled = true;
							size = "3";
							passes = "1";

							vibrancy = "0.1696";
						};
					};

					dwindle = {
						# allegedly deprecated
						#pseudotile = true;
						preserve_split = true;
					};

					master = {
						new_status = "master";
					};

					misc = {
						force_default_wallpaper = "1";
						disable_hyprland_logo = true;
						disable_splash_rendering = true;
					};

					input = {
						kb_layout = "us";
						kb_variant = "";
						kb_model = "";
						kb_options = "";
						kb_rules = "";

						follow_mouse = "1";

						sensitivity = "-0.6";
					};

					bind = [
						"SUPER, Q, exec, hyprctl dispatch exec '[float; size 1000 510]' kitty"
						"SUPER, C, killactive,"
						"SUPER SHIFT, C, exec, kill -9 $(hyprctl activewindow -j | jq -r '.pid')"
						# the only time i pressed this was on accident and then i got sad cuz i had to reopen my windows
						#"SUPER, M, exit,"
						"SUPER, E, exec, thunar"
						"SUPER, V, togglefloating,"
						"SUPER, R, exec, anyrun"
						"SUPER, P, pseudo,"
						"SUPER, J, layoutmsg, togglesplit,"
						"SUPER, L, exec, hyprlock"
						"SUPER, F, fullscreen"

						"SUPER, left, movefocus, l"
						"SUPER, right, movefocus, r"
						"SUPER, up, movefocus, u"
						"SUPER, down, movefocus, d"

						"SUPER, 1, workspace, 1"
						"SUPER, 2, workspace, 2"
						"SUPER, 3, workspace, 3"
						"SUPER, 4, workspace, 4"
						"SUPER, 5, workspace, 5"
						"SUPER, 6, workspace, 6"
						"SUPER, 7, workspace, 7"
						"SUPER, 8, workspace, 8"
						"SUPER, 9, workspace, 9"
						"SUPER, 0, workspace, 10"

						"SUPER SHIFT, 1, movetoworkspace, 1"
						"SUPER SHIFT, 2, movetoworkspace, 2"
						"SUPER SHIFT, 3, movetoworkspace, 3"
						"SUPER SHIFT, 4, movetoworkspace, 4"
						"SUPER SHIFT, 5, movetoworkspace, 5"
						"SUPER SHIFT, 6, movetoworkspace, 6"
						"SUPER SHIFT, 7, movetoworkspace, 7"
						"SUPER SHIFT, 8, movetoworkspace, 8"
						"SUPER SHIFT, 9, movetoworkspace, 9"
						"SUPER SHIFT, 0, movetoworkspace, 10"

						"SUPER SHIFT, LEFT, swapwindow, l"
						"SUPER SHIFT, RIGHT, swapwindow, r"
						"SUPER SHIFT, UP, swapwindow, u"
						"SUPER SHIFT, DOWN, swapwindow, d"

						"SUPER, Z, exec, amixer set Capture toggle"

						"SUPER SHIFT, mouse_down, exec, rmpc volume +5"
						"SUPER SHIFT, mouse_up, exec, rmpc volume -5"
						", code:164, exec, rmpc togglepause"

						"SUPER, x, exec, hyprshot -m region --clipboard-only"
						"SUPER SHIFT, x, exec, hyprshot -m window --clipboard-only"
						"SUPER ALT_L, x, exec, hyprshot -m output --clipboard-only"
					];

					bindm = [
						"SUPER, mouse:272, movewindow"
						"SUPER, mouse:273, resizewindow"
					];

					bindel = [
						",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
						",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
						",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
						",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
						",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
						",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
					];

					bindl = [
						",XF86AudioNext, exec, playerctl next"
						",XF86AudioPause, exec, playerctl play-pause"
						",XF86AudioPlay, exec, playerctl play-pause"
						",XF86AudioPrev, exec, playerctl previous"
					];

					animations = {
						enabled = true;

						bezier = [
							"easeOutQuint, 0.23, 1, 0.32, 1"
							"easeInOutCubic, 0.65, 0.05, 0.36, 1"
							"linear, 0, 0, 1, 1"
							"almostLinear, 0.5, 0.5, 0.75, 1.0"
							"quick, 0.15, 0, 0.1, 1"
						];

						animation = [
							"global, 1, 10, default"
							"border, 1, 5.39, easeOutQuint"
							"windows, 1, 4.79, easeOutQuint"
							"windowsIn, 1, 4.1, easeOutQuint, popin 87%"
							"windowsOut, 1, 1.49, linear, popin 87%"
							"fadeIn, 1, 1.73, almostLinear"
							"fadeOut, 1, 1.46, almostLinear"
							"fade, 1, 3.03, quick"
							"layers, 1, 3.81, easeOutQuint"
							"layersIn, 1, 4, easeOutQuint, fade"
							"layersOut, 1, 1.5, linear, fade"
							"fadeLayersIn, 1, 1.79, almostLinear"
							"fadeLayersOut, 1, 1.39, almostLinear"
							"workspaces, 1, 1.94, almostLinear, fade"
							"workspacesIn, 1, 1.21, almostLinear, fade"
							"workspacesOut, 1, 1.94, almostLinear, fade"
						];
					};

					windowrule = [
						# ignore maximize requests
						"suppress_event maximize, match:class .*"

						# fix XWayland drags
						"no_focus on, match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false"

						# fix picture in picture
						"float on, match:title ^(Picture-in-Picture)$"
						"pin on, match:title ^(Picture-in-Picture)$"
					];

					layerrule = [
						"no_anim on, match:namespace hyprpicker"
						"no_anim on, match:namespace selection"

						"blur on, match:namespace waybar"
					];

					xwayland = {
						#enabled = false;
						force_zero_scaling = true;
					};
				};
			};
		};
}
