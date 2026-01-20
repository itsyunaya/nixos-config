{ pkgs, ... }:

{
  imports = [
    ./terminal/utils.nix
    ./terminal/zsh.nix
    ./terminal/ohmyposh.nix
    ./terminal/kitty.nix
    ./terminal/nvimnvf.nix

    ./syscomponents/anyrun.nix
    ./syscomponents/waybar.nix
    ./syscomponents/hyprland.nix
    ./syscomponents/swaylock.nix

    ./util/keychain.nix
  ];
}
