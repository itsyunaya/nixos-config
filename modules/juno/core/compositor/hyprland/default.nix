{
	osConfig,
	lib,
	inputs,
	pkgs,
	...
}: {
	config =
		lib.mkIf (osConfig.juno-cfg.compositor == "hyprland") {
			wayland.windowManager.hyprland = {
				enable = true;
				package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

				configType = "lua";
				extraConfig = builtins.readFile ./lua/hyprland.lua;
			};

			xdg.configFile."hypr/animations.lua" = lib.mkForce { source = ./lua/animations.lua; };
			xdg.configFile."hypr/binds.lua" = lib.mkForce { source = ./lua/binds.lua; };
			xdg.configFile."hypr/config.lua" = lib.mkForce { source = ./lua/config.lua; };
			xdg.configFile."hypr/events.lua" = lib.mkForce { source = ./lua/events.lua; };
			xdg.configFile."hypr/monitors.lua" = lib.mkForce { source = ./lua/monitors.lua; };
			xdg.configFile."hypr/rules.lua" = lib.mkForce { source = ./lua/rules.lua; };
		};
}
