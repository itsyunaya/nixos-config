# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

let
    username = "ashley";
    musicpresence = pkgs.callPackage ./modules/util/musicpresence.nix {};
in

{
  imports = [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.${username} = { pkgs, ... }: {

    # Symlink the config file
    #xdg.configFile."rmpc/config.ron".source = ./modules/entertainment/rmpc/config.ron;

    # Symlink the entire theme folder
    #home.file."config/rmpc/themes".source = ./modules/entertainment/rmpc/themes;

    # this file imports all other modules
    # its separate cuz i dont wanna clutter my main file
    imports = [
      ./modules/imports.nix
    ];

    programs.rmpc = {
      enable = false;

      config = ''
(
    address: "127.0.0.1:6600",
    //address: "/run/user/1000/mpd/socket",
    password: None,
    //theme: "silly",
    //cache_dir: "/home/ashley/Documents/rmpccache",
    on_song_change: None,
    volume_step: 5,
    max_fps: 30,
    scrolloff: 0,
    wrap_navigation: false,
    enable_mouse: true,
    enable_config_hot_reload: true,
    status_update_interval_ms: 1000,
    rewind_to_start_sec: None,
    reflect_changes_to_playlist: false,
    select_current_song_on_change: false,
    browser_song_sort: [Artist, Title, Track, Disc],
    directories_sort: SortFormat(group_by_type: true, reverse: false),
    album_art: (
        method: Auto,
        max_size_px: (width: 1200, height: 1200),
        disabled_protocols: ["http://", "https://"],
        vertical_align: Center,
        horizontal_align: Center,
    ),
    keybinds: (
        global: {
            ":":       CommandMode,
            ",":       VolumeDown,
            "s":       Stop,
            ".":       VolumeUp,
            "<Tab>":   NextTab,
            "<S-Tab>": PreviousTab,
            "1":       SwitchToTab("Queue"),
            "2":       SwitchToTab("Directories"),
            "3":       SwitchToTab("Artists"),
            "4":       SwitchToTab("Album Artists"),
            "5":       SwitchToTab("Albums"),
            "6":       SwitchToTab("Playlists"),
            "7":       SwitchToTab("Search"),
            "q":       Quit,
            ">":       NextTrack,
            "p":       TogglePause,
            "<":       PreviousTrack,
            "f":       SeekForward,
            "z":       ToggleRepeat,
            "x":       ToggleRandom,
            "c":       ToggleConsume,
            "v":       ToggleSingle,
            "b":       SeekBack,
            "~":       ShowHelp,
            "u":       Update,
            "U":       Rescan,
            "I":       ShowCurrentSongInfo,
            "O":       ShowOutputs,
            "P":       ShowDecoders,
            "R":       AddRandom,
        },
        navigation: {
            "k":         Up,
            "j":         Down,
            "h":         Left,
            "l":         Right,
            "<Up>":      Up,
            "<Down>":    Down,
            "<Left>":    Left,
            "<Right>":   Right,
            "<C-k>":     PaneUp,
            "<C-j>":     PaneDown,
            "<C-h>":     PaneLeft,
            "<C-l>":     PaneRight,
            "<C-u>":     UpHalf,
            "N":         PreviousResult,
            "a":         Add,
            "A":         AddAll,
            "r":         Rename,
            "n":         NextResult,
            "g":         Top,
            "<Space>":   Select,
            "<C-Space>": InvertSelection,
            "G":         Bottom,
            "<CR>":      Confirm,
            "i":         FocusInput,
            "J":         MoveDown,
            "<C-d>":     DownHalf,
            "/":         EnterSearch,
            "<C-c>":     Close,
            "<Esc>":     Close,
            "K":         MoveUp,
            "D":         Delete,
            "B":         ShowInfo,
        },
        queue: {
            "D":       DeleteAll,
            "<CR>":    Play,
            "<C-s>":   Save,
            "a":       AddToPlaylist,
            "d":       Delete,
            "C":       JumpToCurrent,
            "X":       Shuffle,
        },
    ),
    search: (
        case_sensitive: false,
        mode: Contains,
        tags: [
            (value: "any",         label: "Any Tag"),
            (value: "artist",      label: "Artist"),
            (value: "album",       label: "Album"),
            (value: "albumartist", label: "Album Artist"),
            (value: "title",       label: "Title"),
            (value: "filename",    label: "Filename"),
            (value: "genre",       label: "Genre"),
        ],
    ),
    artists: (
        album_display_mode: SplitByDate,
        album_sort_by: Date,
    ),
    tabs: [
        (
            name: "Queue",
            pane: Split(
                direction: Horizontal,
                panes: [(size: "40%", pane: Pane(AlbumArt)), (size: "60%", pane: Pane(Queue))],
            ),
        ),
        (
            name: "Directories",
            pane: Pane(Directories),
        ),
        (
            name: "Artists",
            pane: Pane(Artists),
        ),
        (
            name: "Album Artists",
            pane: Pane(AlbumArtists),
        ),
        (
            name: "Albums",
            pane: Pane(Albums),
        ),
        (
            name: "Playlists",
            pane: Pane(Playlists),
        ),
        (
            name: "Search",
            pane: Pane(Search),
        ),
    ],
)
      '';
    };

    # Manage some system component themes without stylix
    stylix = {

      targets = {
        hyprland.enable = false;
        kitty.enable = false;
        waybar.enable = false;
      };
    };


    services.swww = {
      enable = true;
    };

    services.nextcloud-client = {
      enable = true;
    };

    services.mpd = {
      enable = true;
      musicDirectory = "/home/ashley/Nextcloud/music";

      extraConfig = ''
        auto_update "yes"

	audio_output {
        type "pulse"
        name "mraow"
      }
      '';
    };

    services.mpd-mpris.enable = true;

    gtk = {
      iconTheme = {
	name = "WhiteSur";
	package = pkgs.whitesur-icon-theme;
      };
    };

    qt = {
      enable = true;
      style = {
	#name = lib.mkForce "WhiteSur";
        package = pkgs.whitesur-icon-theme;
      };
    };

    home.packages = with pkgs; [
      btop
      vesktop
      pavucontrol
      alsa-utils
      inputs.zen-browser.packages."${system}".default
      prismlauncher
      xlsclients
      mpdas
      jetbrains.idea
      jetbrains.webstorm
      zenity
      kdePackages.dolphin
      steam
      musicpresence
    ];
    
    home.stateVersion = "25.05";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    twemoji-color-font
  ];

  fonts.fontconfig.defaultFonts = {
    emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
  };

  programs.zsh.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "ashley";
    extraGroups = [ "networkmanager" "wheel" "audio" "seat" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  stylix = {
    enable = true;
    
    cursor = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
      size = 24;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  firefox
  whitesur-cursors
  hyprshot
  hyprpicker
  playerctl
  xdg-utils
  wl-clipboard
  rmpc
  gcc
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "";
  };

  security.sudo.extraConfig = "
    Defaults pwfeedback
  ";

  security.rtkit.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.displayManager.lemurs.enable = true;

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  systemd.user.services.pipewire-pulse = {
    enable = true;
  };

  systemd.user.sockets.pipewire = {
    enable = true;
  };

  systemd.user.sockets.pipewire-pulse = {
    enable = true;
  };

        #  systemd.user.services.musicpresence = {
                #enable = true;
                #description = "Discord music presence";
                #wantedBy = [ "default.target" ];
                #serviceConfig = {
                #Type = "simple";
                #After = "graphical-session.target";
                #ExecStart = "${musicpresence}/bin/musicpresence";
                #Environment = '' XDG_RUNTIME_DIR=/run/user/%U DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus DISPLAY=:0 QT_QPA_PLATFORM=xcb LD_LIBRARY_PATH=${pkgs.libxcb-cursor}/lib:${pkgs.libxcb}/lib:${pkgs.libGLvnd}/lib:${pkgs.fontconfig}/lib:${pkgs.freetype}/lib QT_PLUGIN_PATH=${pkgs.qt6.qtbase}/lib/qt6/plugins '';
                #Restart = "on-failure";
                #RestartSec = "5s";
                #WorkingDirectory = "%h";
                #};
        #};

  systemd.user.services.mpdas = {
    description = "mpdas music scrobbler";
    wantedBy = [ "default.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.mpdas}/bin/mpdas";
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    nvidiaSettings = true;
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
