# nix-config
## Introduction

This is my personal Nix (Flakes) configuration made for a few of my devices. It is a
continuation of my [previous attempt](https://github.com/itsyunaya/nixos-config-old) of
getting acquainted with Nix, but now actually stable and usable as a daily driver

## Specifications
### Hosts

> [!CAUTION]
> If you wish to use any of these configurations on your own device, you need
> to first replace the respective hardware configuration with your own.
> Otherwise your system will not boot!

| Host                  | Description                                      |
|-----------------------|--------------------------------------------------|
| `juno`                | Main x86 Linux machine                           |
| `ceres`               | Raspberry Pi nixOS setup for pi-hole             |
| `callisto`            | WIP server configuration                         |
| `ashleys-macbook-pro` | Apple Silicon Mac configuration using nix-darwin |

### juno

This configuration features a dual compositor setup with MangoWM and Hyprland, 
wherein it is possible to switch between the two just by setting a config option
in `configuration.nix`, under the `juno-cfg` attrset. Further options like
the active lockscreen app or terminal can also be configured.

Other than that, this is a fairly regular config including Waybar, Anyrun, Dunst, etc.
but also a plethora of packages I personally use.

### ceres

Minimal NixOS config just for deploying [Pi-Hole](https://pi-hole.net/) on a Raspberry Pi 4B.
Make sure you have enough storage on your device before building for the 
first time (>32GB) since otherwise the build may fail. Also note that it 
will take a very long time to complete.

### callisto

Very work in progress server configuration including but not limited to:
- Nextcloud & Samba Servers for data management
- Monitoring via Grafana
- Various Webservers
- Gameservers

### ashleys-macbook-pro

Minimal nix-darwin configuration with home-manager. Only has some basic packages and a 
simple shell setup for now.

## Other

~~The packages directory includes sofware I've packaged myself.~~ 
The only package I put there has been moved to 
[its own flake](https://github.com/itsyunaya/musicpresence-flake).

## Note

This config is still work in progress and may change drastically at any time.