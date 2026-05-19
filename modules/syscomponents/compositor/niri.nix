{
	osConfig,
	config,
	lib,
	pkgs,
	...
}: {
	config =
		lib.mkIf (osConfig.itsyunaya-nix.compositor == "niri") {
			programs.niri = {
				package = pkgs.niri-unstable;

				settings = {
					outputs = {
						"DP-3" = {
							mode = {
								width = 2560;
								height = 1440;
								refresh = 144.0;
							};

							scale = 1.25;
							position = {
								x = 1920;
								y = 0;
							};
						};

						"DP-2" = {
							position = {
								x = 0;
								y = 0;
							};
						};
					};

					prefer-no-csd = true;

					layout = {
						focus-ring.enable = false;
						gaps = 8;

						border = {
							enable = true;
							width = 3;

							active.gradient = {
								from = "#ffc8dd";
								to = "#cdb4db";
								angle = 45;
							};

							inactive.color = "#595959";
						};

						shadow = {
							enable = true;
							color = "#1a1a1aee";
							softness = 30;
							spread = 5;
						};
					};

					animations = {
						window-open.kind."easing" = {
							duration-ms = 400;
							curve = "ease-out-expo";
						};

						window-close.kind."easing" = {
							duration-ms = 150;
							curve = "ease-out-quad";
						};

						horizontal-view-movement.kind."easing" = {
							duration-ms = 200;
							curve = "ease-out-cubic";
						};

						workspace-switch.kind."easing" = {
							duration-ms = 200;
							curve = "ease-out-cubic";
						};
					};

					window-rules = [
						{
							# rounded corner rule
							draw-border-with-background = false;
							geometry-corner-radius = {
								top-left = 12.0;
								top-right = 12.0;
								bottom-left = 12.0;
								bottom-right = 12.0;
							};

							clip-to-geometry = true;
						}
						{
							# spawn kitty floating rule
							matches = [{app-id = "kitty-float";}];
							open-floating = true;
							default-window-height = {fixed = 510;};
							default-column-width = {fixed = 1000;};
						}
						{
							# pip fix rule
							matches = [{title = "^Picture-in-Picture$";}];
							open-floating = true;
							# open-on-all-workspaces = true;
						}
					];

					# autofocus windows on mouse hover
					input.focus-follows-mouse = {
						enable = true;
						# if a window thats not entirely within the workspace is present
						# and requires scrolling, its ignored
						max-scroll-amount = "0%";
					};

					binds = with config.lib.niri.actions; {
						"Mod+Q".action.spawn = ["kitty" "--class" "kitty-float"];

						"Mod+C".action = close-window;
						"Mod+F".action = fullscreen-window;
						"Mod+V".action = toggle-window-floating;

						"Mod+Left".action = focus-column-left;
						"Mod+Right".action = focus-column-right;
						"Mod+Up".action = focus-window-up;
						"Mod+Down".action = focus-window-down;

						"Mod+Shift+Left".action = move-column-left;
						"Mod+Shift+Right".action = move-column-right;
						"Mod+Shift+Up".action = move-window-up;
						"Mod+Shift+Down".action = move-window-down;

						"Mod+1".action = focus-workspace 1;
						"Mod+2".action = focus-workspace 2;
						"Mod+3".action = focus-workspace 3;
						"Mod+4".action = focus-workspace 4;
						"Mod+5".action = focus-workspace 5;
						"Mod+6".action = focus-workspace 6;
						"Mod+7".action = focus-workspace 7;
						"Mod+8".action = focus-workspace 8;
						"Mod+9".action = focus-workspace 9;

						"Mod+Shift+1".action.move-window-to-workspace = 1;
						"Mod+Shift+2".action.move-window-to-workspace = 2;
						"Mod+Shift+3".action.move-window-to-workspace = 3;
						"Mod+Shift+4".action.move-window-to-workspace = 4;
						"Mod+Shift+5".action.move-window-to-workspace = 5;
						"Mod+Shift+6".action.move-window-to-workspace = 6;
						"Mod+Shift+7".action.move-window-to-workspace = 7;
						"Mod+Shift+8".action.move-window-to-workspace = 8;
						"Mod+Shift+9".action.move-window-to-workspace = 9;

						"Mod+Z".action = spawn "amixer" "set" "Capture" "toggle";
						"XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "-1" "1" "@DEFAULT_AUDIO_SINK@" "5%+";
						"XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
						"XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
						"XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

						"XF86AudioNext".action = spawn "playerctl" "next";
						"XF86AudioPrev".action = spawn "playerctl" "previous";
						"XF86AudioPlay".action = spawn "playerctl" "play-pause";
						"XF86AudioPause".action = spawn "playerctl" "play-pause";
						#"code:164".action = spawn "playerctl" "play-pause";
					};
				};
			};
		};
}
