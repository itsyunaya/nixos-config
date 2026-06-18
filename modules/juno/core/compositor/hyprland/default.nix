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
				extraConfig = builtins.readFile ./hyprland.lua;
			};
		};
}
