{ ... }:

let
	# "hyprland" or "niri"
	compositor = "hyprland";
in {
	imports = [ ] ++ (
		if compositor == "hyprland" then [ ./_hyprland.nix ]
    	else if compositor == "niri" then [ ./_niri.nix ]
    	else throw "Invalid compositor: ${compositor}."
	);
}