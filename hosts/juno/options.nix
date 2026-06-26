{ lib, ... }:

{
	options.juno-cfg = {
		compositor = lib.mkOption {
			type = lib.types.enum [ "hyprland" "mango" ];
			default = "hyprland";
			description = "Which compositor to choose (hypr/niri/mango)";
		};

		lock-app = lib.mkOption {
			type = lib.types.enum [ "swaylock" "hyprlock" ];
			default = "swaylock";
			description = "Which lockscreen app to use (sway/hypr)";
		};

		sh = {
			zshEnableExtraCustomization = lib.mkOption {
				type = lib.types.bool;
				default = false;
				description = "If omz/omp should be enabled";
			};
		};
	};
}
