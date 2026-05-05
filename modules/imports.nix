{ config, ... }:

let
	# "hyprland" or "niri"
	compositor = "hyprland";
in {
	imports = [
		./terminal/utils.nix
		./terminal/zsh.nix
		./terminal/ohmyposh.nix
		./terminal/kitty.nix
		#./terminal/nvim.nix
		
		./syscomponents/anyrun.nix
		./syscomponents/waybar.nix
        #./syscomponents/swaylock.nix
        #./syscomponents/hyprlock.nix
		./syscomponents/dunst.nix

		./util/keychain.nix
		#./util/vscode.nix

		./media/vesktop/default.nix
		./media/rmpc/default.nix

	] ++ (
		if compositor == "hyprland" then [ ./syscomponents/hyprland.nix ]
		else if compositor == "niri" then [ ./syscomponents/niri.nix ]
		else throw "Invalid compositor: ${compositor}."
	);
}
