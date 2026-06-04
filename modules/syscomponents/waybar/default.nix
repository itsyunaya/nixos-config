{ osConfig, ... }:

{
	programs.waybar = {
		enable = true;

		settings = {
			mainBar = {
				position = "top";
				layer = "top";
				height = 40;
				margin-top = 0;
				margin-bottom = 0;
				margin-left = 0;
				margin-right = 0;

				modules-left = [
					"custom/launcher"
				] ++ (
					if (osConfig.itsyunaya-nix.compositor == "hyprland") then ["hyprland/workspaces"]
					else if (osConfig.itsyunaya-nix.compositor == "mango") then ["ext/workspaces"]
					else []
				)
				++ [
					"custom/playerctl"
					"custom/playerlabel"
				];

				modules-center =
					if (osConfig.itsyunaya-nix.compositor == "hyprland") then ["hyprland/window"]
					else if (osConfig.itsyunaya-nix.compositor == "mango") then ["dwl/window"]
					else [];

				modules-right = [
					"tray"
					"custom/colourpicker"
					"bluetooth"
					"cpu"
					"memory"
					"pulseaudio#input"
					"pulseaudio"
					"clock"
				];

				clock = {
					format = " {:%H:%M}";
					tooltip = true;
					tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
					format-alt = " {:%d/%m}";
				};

				"hyprland/window" = {
					max-length = 120;
				};

				"dwl/window" = {
					max-length = 120;
				};

				"hyprland/workspaces" = {
					active-only = false;
					all-outputs = true;
					disable-scroll = false;
					on-scroll-up = "hyprctl dispatch workspace -1";
					on-scroll-down = "hyprctl dispatch workspace +1";
					format = "{icon}";
					on-click = "activate";
					format-icons = {
						urgent = "";
						active = "";
						default = "󰧞";
					};
					sort-by-number = true;
				};

				"ext/workspaces" = {
					on-click = "activate";
				};

				"custom/playerctl" = {
					format = "{icon}";
					return-type = "json";
					max-length = 64;
					exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
					on-click-middle = "playerctl previous";
					on-click = "playerctl play-pause";
					on-click-right = "playerctl next";
					format-icons = {
						Playing = "<span foreground='#E5B9C6'>󰒮 󰐌 󰒭</span>";
						Paused = "<span foreground='#928374'>󰒮 󰏥 󰒭</span>";
					};
				};

				"custom/playerlabel" = {
					format = "<span>{}</span>";
					return-type = "json";
					max-length = 48;
					exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
					on-click-middle = "playerctl play-pause";
					on-click = "playerctl previous";
					on-click-right = "playerctl next";
					format-icons = {
						Playing = "<span foreground='#E5B9C6'>  </span>";
						Paused = "<span foreground='#928374'>  </span>";
					};
				};

				memory = {
					format = "󰍛 {}%";
					format-alt = " {used}/{total} GiB";
					interval = 5;
				};

				cpu = {
					format = "󰻠 {usage}%";
					format-alt = " {avg_frequency} GHz";
					interval = 5;
				};

				tray = {
					icon-size = 16;
					spacing = 5;
				};

				pulseaudio = {
					format = "{icon} {volume}%";
					format-muted = "󰝟";
					format-icons.default = [
						"󰕿"
						"󰖀"
						"󰕾"
					];
					on-click = "hyprctl dispatch exec '[float; size 1000 500]' pavucontrol";
					scroll-step = 5;
					on-click-right = "pavucontrol";
				};

				"pulseaudio#input" = {
					format-source = " {volume}%";
					format-source-muted = "  off";
					format = "{format_source}";
					scroll-step = 1;
					smooth-scrolling-threshold = 1;
					on-click = "amixer sset 'Capture' toggle";
					on-click-middle = "pavucontrol";
					on-scroll-up = "amixer sset 'Capture' 2%+";
					on-scroll-down = "amixer sset 'Capture' 2%-";
				};

				"bluetooth" = {
					format-on = "󰂯";
					format-off = "󰂲";
					format-disabled = "";
					format-connected = "󰂱 {num_connections}";
					tooltip-format-connected = "{device_enumerate}";
					tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
					on-click = "bluetoothctl power on";
					on-click-right = "bluetoothctl power off";
				};

				"custom/launcher" = {
					format = "󱄅";
					on-click = "bash $HOME/.config/waybar/run.sh wofi";
					on-click-right = "bash $HOME/.config/waybar/run.sh kitty";
				};

				"custom/colourpicker" = {
					format = "󰈋";
					on-click = "hyprpicker -a -f hex";
					on-click-right = "hyprpicker -a -f rgb";
				};
			};
		};

		style = builtins.readFile ./style.css;
	};
}
