{ lib, ... }:

{
	options.itsyunaya-nix = {
		compositor = lib.mkOption {
        	type = lib.types.enum [ "hyprland" /*"niri"*/ "mango" ];
        	default = "hyprland";
        	description = "Which compositor to choose (hypr/niri/mango)";
        };

        lock-app = lib.mkOption {
        	type = lib.types.enum [ "swaylock" "hyprlock" ];
        	default = "swaylock";
        	description = "Which lockscreen app to use (sway/hypr)";
        };

        shell = lib.mkOption {
        	type = lib.types.enum [ "zsh" "nushell" ];
        	default =  "zsh";
        	description = "Which shell to use";
        };

        terminal = lib.mkOption {
        	type = lib.types.enum [ "kitty" "ghostty" ];
        	default = "kitty";
        	description = "Which terminal emulator to use";
        };
	};
}
