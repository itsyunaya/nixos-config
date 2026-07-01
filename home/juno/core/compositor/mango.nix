{
	osConfig,
	lib,
	theme,
	...
}: {
	/*
		list of things that need to be resolved before mango is stable for me:
			-	crash with kitty fixed (https://github.com/mangowm/mango/issues/789)
			-	screen sharing fixed (unknown issue)
	*/

	config =
		lib.mkIf (osConfig.juno-cfg.compositor == "mango") {
			wayland.windowManager.mango = {
				enable = true;
				systemd.enable = true;

				autostart_sh = ''
					waybar &
					awww-daemon &
					awww img ${theme.wallpaper}
					mpd-mpris &
					yams &
					musicpresence &
					fcitx5 &
					anyrun daemon &
					playerctld &
				'';

				settings = {
					monitorrule = [
						"name:^DP-3$,width:2560,height:1440,refresh:144,x:1920,y:0,scale:1.25"
						"name:^DP-2$,width:1920,height:1080,refresh:60,x:0,y:0,scale:1"
					];

					syncobj_enable = 1;

					gappih = 3;
					gappiv = 3;
					gappoh = 7;
					gappov = 7;
					borderpx = 2;

					focuscolor = "0x${theme.colours.accent-pink}ee";
					bordercolor = "0x${theme.colours.bg-lighter}ee";

					border_radius = 10;
					focused_opacity = 1.0;
					unfocused_opacity = 1.0;

					blur = 1;
					blur_optimized = 0;
					blur_params_radius = 1;
					blur_params_num_passes = 1;
					blur_layer = 1;

					shadows = 1;
					shadow_only_floating = 1;
					shadows_size = 4;
					shadows_blur = 12;
					shadows_position_x = 0;
					shadows_position_y = 0;
					shadowscolor = "0x1a1a1aee";

					animations = 1;

					animation_type_open = "zoom";
					animation_type_close = "zoom";

					animation_duration_open = 410;
					animation_duration_close = 300;
					animation_duration_move = 480;
					animation_duration_tag = 194;

					animation_curve_open  = "0.23,1,0.32,1";
					animation_curve_close = "0,0,1,1";
					animation_curve_move  = "0.23,1,0.32,1";
					animation_curve_tag   = "0.5,0.5,0.75,1.0";

					animation_fade_in = 1;
					animation_fade_out = 1;
					animation_curve_opafadein  = "0.5,0.5,0.75,1.0";
					animation_curve_opafadeout = "0.5,0.5,0.75,1.0";

					bind = [
						"SUPER,E,spawn,thunar"
						"SUPER,R,spawn,anyrun"

						"SUPER,C,killclient"
						"SUPER+SHIFT,C,spawn_shell,kill -9 $(mmsg -j activewindow | jq -r .pid)"

						"SUPER,M,reload_config"

						"SUPER,V,togglefloating"
						"SUPER,F,togglefullscreen"
						"SUPER,J,dwindle_toggle_split_direction"

						"SUPER,L,spawn,hyprlock"

						"SUPER,left,focusdir,left"
						"SUPER,right,focusdir,right"
						"SUPER,up,focusdir,up"
						"SUPER,down,focusdir,down"

						"SUPER,1,view,1"
						"SUPER,2,view,2"
						"SUPER,3,view,3"
						"SUPER,4,view,4"
						"SUPER,5,view,5"
						"SUPER,6,view,6"
						"SUPER,7,view,7"
						"SUPER,8,view,8"
						"SUPER,9,view,9"
						"SUPER,0,view,0"

						"SUPER+SHIFT,1,tag,1"
						"SUPER+SHIFT,2,tag,2"
						"SUPER+SHIFT,3,tag,3"
						"SUPER+SHIFT,4,tag,4"
						"SUPER+SHIFT,5,tag,5"
						"SUPER+SHIFT,6,tag,6"
						"SUPER+SHIFT,7,tag,7"
						"SUPER+SHIFT,8,tag,8"
						"SUPER+SHIFT,9,tag,9"
						"SUPER+SHIFT,0,tag,0"

						"SUPER+SHIFT,left,exchange_client,left"
						"SUPER+SHIFT,right,exchange_client,right"
						"SUPER+SHIFT,up,exchange_client,up"
						"SUPER+SHIFT,down,exchange_client,down"

						"SUPER,Z,spawn_shell,amixer set Capture toggle"
						"NONE,code:164,spawn,rmpc togglepause"

						"SUPER,x,spawn,hyprshot -m region --clipboard-only"
						"SUPER+SHIFT,x,spawn,hyprshot -m window --clipboard-only"
						"SUPER+ALT,x,spawn,hyprshot -m output --clipboard-only"

						"NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
						"NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
						"NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
						"NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
						"NONE,XF86MonBrightnessUp,spawn,brightnessctl -e4 -n2 set 5%+"
						"NONE,XF86MonBrightnessDown,spawn,brightnessctl -e4 -n2 set 5%-"
					] ++ (
						if (osConfig.juno-cfg.terminal == "kitty") then ["SUPER,Q,spawn,kitty"]
						else if (osConfig.juno-cfg.terminal == "ghostty") then ["SUPER,Q,spawn,ghostty"]
						else []
					);

					bindl = [
						"NONE,XF86AudioNext,spawn,playerctl next"
						"NONE,XF86AudioPause,spawn,playerctl play-pause"
						"NONE,XF86AudioPlay,spawn,playerctl play-pause"
						"NONE,XF86AudioPrev,spawn,playerctl previous"
					];

					mousebind = [
						"SUPER,btn_left,moveresize,curmove"
						"SUPER,btn_right,moveresize,curresize"
					];

					axisbind = [
						"SUPER+SHIFT,DOWN,spawn,rmpc volume +5"
						"SUPER+SHIFT,UP,spawn,rmpc volume -5"
					];

					windowrule = [
						"ignore_maximize:1,appid:.*"

						"isfloating:1,title:^Picture-in-Picture$"
						"isglobal:1,title:^Picture-in-Picture$"

						#"isnoanimation:1,appid:hyprpicker"
					] ++ (
						if (osConfig.juno-cfg.terminal == "kitty") then ["isfloating:1,width:1000,height:510,appid:kitty"]
						else if (osConfig.juno-cfg.terminal == "ghostty") then ["isfloating:1,width:1000,height:550,appid:ghostty"]
						else []
					);
				};

			};
		};
}
