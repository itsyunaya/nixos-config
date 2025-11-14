# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

let
    username = "ashley";
in

{
  imports = [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.ashley = { pkgs, ... }: {

    # Symlink the config file
    #xdg.configFile."rmpc/config.ron".source = ./modules/entertainment/rmpc/config.ron;

    # Symlink the entire theme folder
    #home.file."config/rmpc/themes".source = ./modules/entertainment/rmpc/themes;

    programs.nvf = {
      enable = true;

      settings = {
        vim = {
          startPlugins = [
            pkgs.vimPlugins.vimtex
            pkgs.vimPlugins.transparent-nvim
          ];

          luaConfigRC.nvimConfigDir = ''
            vim.o.clipboard = 'unnamedplus' 
          '';
          
          languages = {
            enableTreesitter = true;

            nix = {
              enable = true;
              format.enable = true;
            };
          };

          lsp = {
            enable = true;

            servers.nix.enable = true;
          };

          mini.pairs = {
            enable = true;

            setupOpts = {
              modes = { insert = true; command = true; terminal = false; };

              skip_next = "[=[[%w%%%'%[%\"%.%`%$]]=]";

              skip_ts = true;

              skin_unbalanced = true;
            };
          };

          statusline.lualine = {
            enable = true;
          };

          telescope = {
            enable = true;
          };
        };
      };
    };

    programs.rmpc = {
      enable = true;

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
    stylix.targets = {
      hyprland.enable = false;
      kitty.enable = false;
      waybar.enable = false;
    };

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y";
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion = {
	enable = true;
      };

      syntaxHighlighting = {
	enable = true;

	styles = {
	 # Comments
          comment = "fg=#5b6078";

          # Functions / commands
          alias = "fg=#a6da95";
          suffix-alias = "fg=#a6da95";
          global-alias = "fg=#a6da95";
          function = "fg=#a6da95";
          command = "fg=#a6da95";
          precommand = "fg=#a6da95,italic";
          autodirectory = "fg=#f5a97f,italic";
          single-hyphen-option = "fg=#f5a97f";
          double-hyphen-option = "fg=#f5a97f";
          back-quoted-argument = "fg=#c6a0f6";

          # Builtins / keywords
          builtin = "fg=#a6da95";
          reserved-word = "fg=#a6da95";
          hashed-command = "fg=#a6da95";

          # Punctuation
          commandseparator = "fg=#ed8796";
          command-substitution-delimiter = "fg=#cad3f5";
          command-substitution-delimiter-unquoted = "fg=#cad3f5";
          process-substitution-delimiter = "fg=#cad3f5";
          back-quoted-argument-delimiter = "fg=#ed8796";
          back-double-quoted-argument = "fg=#ed8796";
          back-dollar-quoted-argument = "fg=#ed8796";

          # Strings
          command-substitution-quoted = "fg=#eed49f";
          command-substitution-delimiter-quoted = "fg=#eed49f";
          single-quoted-argument = "fg=#eed49f";
          single-quoted-argument-unclosed = "fg=#ee99a0";
          double-quoted-argument = "fg=#eed49f";
          double-quoted-argument-unclosed = "fg=#ee99a0";
          rc-quote = "fg=#eed49f";

          # Variables
          dollar-quoted-argument = "fg=#cad3f5";
          dollar-quoted-argument-unclosed = "fg=#ee99a0";
          dollar-double-quoted-argument = "fg=#cad3f5";
          assign = "fg=#cad3f5";
          named-fd = "fg=#cad3f5";
          numeric-fd = "fg=#cad3f5";

          # Misc
          unknown-token = "fg=#ee99a0";
          path = "fg=#cad3f5,underline";
          path_pathseparator = "fg=#ed8796,underline";
          path_prefix = "fg=#cad3f5,underline";
          path_prefix_pathseparator = "fg=#ed8796,underline";
          globbing = "fg=#cad3f5";
          history-expansion = "fg=#c6a0f6";
          back-quoted-argument-unclosed = "fg=#ee99a0";
          redirection = "fg=#cad3f5";
          arg0 = "fg=#cad3f5";
          default = "fg=#cad3f5";
          cursor = "fg=#cad3f5"; 
	};
      };

      oh-my-zsh = {
	enable = true;
	plugins = [
	  "git"
	  "eza"
	];
      };
    };

    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;

      settings = builtins.fromJSON ''
        {
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
    {
      "alignment": "left",
      "segments": [
        {
          "background": "#575656",
          "foreground": "#FFFFFF",
          "leading_diamond": "\ue0b6",
          "style": "diamond",
          "properties": {
            "alma": "\uF31D ALMA",
            "almalinux": "\uF31D ALML",
            "almalinux9": "\uF31D ALL9",
            "alpine": "\uF300 ALPN",
            "android": "\uF17b ANDR",
            "aosc": "\uF301 AOSC",
            "arch": "\uF303 ARCH",
            "centos": "\uF304 CENT",
            "coreos": "\uF305 CORE",
            "debian": "\uF306 DEBN",
            "deepin": "\uF321 DEEP",
            "devuan": "\uF307 DEVN",
            "elementary": "\uF309 ELMT",
            "endeavouros": "\uF322 EDOS",
            "fedora": "\uF30a FEDR",
            "gentoo": "\uF30d GENT",
            "mageia": "\uF310 MAGE",
            "manjaro": "\uF312 MANJ",
            "mint": "\uF30e MINT",
            "nixos": "\uF313 NIXS",
            "opensuse": "\uF314 SUSE",
            "opensuse-tumbleweed": "\uF314 SSTW",
            "raspbian": "\uF315 RASP",
            "redhat": "\uF316 RDHT",
            "rocky": "\uF32B ROCK",
            "sabayon": "\uF317 SBYO",
            "slackware": "\uF319 SLCK",
            "ubuntu": "\uF31b UBNT"
          },
          "template": "<b>\udb82\udee2  {{ .UserName }} </b>",
          "type": "os"
        },
        {
          "background": "#a6da95",
          "background_templates": [
            "{{ if gt .Code 0 }}#ED8796{{ end }}"
          ],
          "foreground": "#000000",
          "foreground_templates": [
            "{{ if gt .Code 0 }}#FFFFFF{{ end }}"
          ],
          "leading_diamond": "\ue0b2",
          "properties": {
            "always_enabled": true
          },
          "style": "diamond",
          "template": "{{ if gt .Code 0 }}\uf00d{{ else }}\uf00c{{ end }}",
          "type": "status",
          "trailing_diamond": "\ue0b0"
        },
        {
          "background": "#575656",
          "foreground": "#FFFFFF",
          "properties": {
            "style": "roundrock",
            "threshold": 0
          },
          "style": "diamond",
          "template": " \uf252 {{ .FormattedMs }}",
          "trailing_diamond": "\ue0b0",
          "type": "executiontime"
        },
        {
          "background": "#F46C6B",
          "foreground": "#000000",
          "powerline_symbol": "\ue0b0",
          "style": "powerline",
          "template": "<b> \uf09c root </b>",
          "type": "root"
        },
        {
          "type": "cmake",
          "style": "powerline",
          "powerline_symbol": "\ue0b0",
          "foreground": "#E8EAEE",
          "background": "#1E9748",
          "template": " \ue61e \ue61d cmake {{ .Full }} "
        },
        {
          "type": "python",
          "style": "powerline",
          "powerline_symbol": "\ue0b0",
          "properties": {
            "display_mode": "context"
          },
          "foreground": "#000000",
          "foreground_templates": [
            "{{ if .Venv }}#FFFFFF{{ end }}"
          ],
          "background": "#EBFF3B",
          "background_templates": [
            "{{ if .Venv}}#356C9C{{ end }}"
          ],
          "template": " <b>\ue73c {{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}</b> "
        },
        {
          "type": "go",
          "style": "powerline",
          "powerline_symbol": "\ue0b0",
          "foreground": "#000000",
          "background": "#7FD5EA",
          "template": " \u202d\ue626 {{ .Full }} "
        },
        {
          "type": "rust",
          "style": "powerline",
          "powerline_symbol": "\ue0b0",
          "foreground": "#e2f3ff",
          "background": "#684e3d",
          "template": " \ue7a8 {{ .Full }} "
        },
        {
          "background": "#D53010",
          "foreground": "#FFFFFF",
          "powerline_symbol": "\ue0b0",
          "properties": {
            "branch_icon": " ",
            "fetch_stash_count": true,
            "fetch_status": true,
            "fetch_upstream_icon": true,
            "fetch_worktree_count": true
          },
          "style": "powerline",
          "template": "<b> {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#CAEBE1> \uf046 {{ .Staging.String }}</>{{ end }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} </b>",
          "type": "git"
        }
      ],
      "type": "prompt"
    },
    {
      "alignment": "left",
      "newline": true,
      "type": "prompt",
      "segments": [
        {
          "foreground": "#D6DEEB",
          "style": "plain",
          "template": "\u256d\u2500",
          "type": "text"
        },
        {
          "leading_diamond": "",
          "properties": {
            "folder_icon": " \uf07c ",
            "folder_separator_icon": " <#D6DEEB>\uf061</> ",
            "home_icon": "\uf015 ",
            "style": "agnoster_short",
            "max_depth": 4,
            "right_format": "<u><b>%s</b></u>",
            "mapped_locations": {
              "~/videos": "\uf015 <#D6DEEB>\uf061</> \uf03d",
              "~/desktop": "\uf015 <#D6DEEB>\uf061</> \uf108",
              "~/documents": "\uf015 <#D6DEEB>\uf061</> \udb80\ude19",
              "~/downloads": "\uf015 <#D6DEEB>\uf061</> \uf019",
              "~/pictures": "\uf015 <#D6DEEB>\uf061</> \uf03e",
              "~/music": "\uf015 <#D6DEEB>\uf061</> \uf001",
              "~/git": "\uf015 <#D6DEEB>\uf061</> \ue702",
              "~/public": "\uf015 <#D6DEEB>\uf061</> \uf0c0",
              "~/templates": "\uf015 <#D6DEEB>\uf061</> \uf509",
              "~/wine": "\uf015 <#D6DEEB>\uf061</> \uedae",
              "~/workdir": "\uf015 <#D6DEEB>\uf061</> \uedc8 ",
              "~/.config": "\uf015 <#D6DEEB>\uf061</> \udb84\udc7f",
              "~/.local": "\uf015 <#D6DEEB>\uf061</> \udb86\uddfc",
              "~/.steam": "\uf015 <#D6DEEB>\uf061</> \ued29",
              "~/.cache": "\uf015 <#D6DEEB>\uf061</> \udb82\udeba",
              "~/games": "\uf015 <#D6DEEB>\uf061</> \uf11b "
            }
          },
          "style": "diamond",
          "template": "  <#fcffff>{{ if not .Writable }}<#FF4444>\uf09c {{ end }}{{ if .RootDir }}\ue216{{ else }}{{ .Path }}{{ end }}</> ",
          "type": "path"
        }
      ]
    },
    {
      "alignment": "left",
      "newline": true,
      "segments": [
        {
          "foreground": "#D6DEEB",
          "style": "plain",
          "template": "\u2570\u2500",
          "type": "text"
        },
        {
          "foreground": "#D6DEEB",
          "properties": {
            "always_enabled": true
          },
          "style": "plain",
          "template": "\uedfb ",
          "type": "status"
        }
      ],
      "type": "prompt"
    }
  ],
  "osc99": true,
  "transient_prompt": {
    "background": "transparent",
    "foreground": "#FEF5ED",
    "template": "\ue285 "
  },
  "secondary_prompt": {
    "background": "transparent",
    "foreground": "#D6DEEB",
    "template": "\u2570\u2500\u276f "
  },
  "version": 3
}
      '';
    };

    programs.git = {
      enable = true;

      settings = {
	user.name = "Xanover";
	user.email = "40719746+Xanover@users.noreply.github.com";
	# dont use actual email cuz i dont wanna dox myself yk
      };
    };

    programs.kitty = {
      enable = true;

      font = {
        name = "JetBrainsMono Nerd Font";
      };

      settings = {
	cursor_trail = "1";
	enable_audio_bell = "no";
	window_margin_width = "8";
	background_opacity = "0.7";
      };
    };

    programs.neovim = {
      enable = true;
    };

    programs.waybar = {
      enable = true;

      settings = {
	mainBar = {
	  position = "top";
	  layer = "top";
	  height = 16;
	  margin-top = 0;
	  margin-bottom = 0;
	  margin-left = 0;
	  margin-right = 0;

	  modules-left = [
	    "custom/launcher"
	    "hyprland/workspaces"
	    "custom/playerctl"
	    "custom/playerlabel"
	  ];

	  modules-center = [ "hyprland/window" ];

	  modules-right = [
	    "tray"
            "custom/hyprpicker"
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
            format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
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

	  "custom/launcher" = {
            format = "󱄅";
            on-click = "bash $HOME/.config/waybar/run.sh wofi";
            on-click-right = "bash $HOME/.config/waybar/run.sh kitty";
          };

	  "custom/hyprpicker" = {
            format = "";
            on-click = "hyprpicker -a -f hex";
            on-click-right = "hyprpicker -a -f rgb";
          };

	};	
      };

      style = ''
	* {
    border: none;
    border-radius: 0px;
    /*font-family: VictorMono, Iosevka Nerd Font, Noto Sans CJK;*/
    /*font-family: Iosevka, FontAwesome, Noto Sans CJK;*/
    font-family: JetBrainsMono Nerd Font, Noto Sans CJK;
    font-size: 14px;
    font-style: normal;
    min-height: 0;
}

window#waybar {
    background: rgba(30, 30, 46, 0.9);
    border-bottom: 1px solid #282828;
    color: #f4d9e1
}

#workspaces {
	background: #282828;
	margin: 5px 5px 5px 5px;
  padding: 0px 5px 0px 5px;
	border-radius: 16px;
  border: solid 0px #f4d9e1;
  font-weight: normal;
  font-style: normal;
}
#workspaces button {
    padding: 0px 5px;
    border-radius: 16px;
    color: #928374;
}

#workspaces button.active {
    color: #f4d9e1;
    background-color: transparent;
    border-radius: 16px;
}

#workspaces button:hover {
	background-color: #E6B9C6;
	color: black;
	border-radius: 16px;
}

#custom-date, #clock, #battery, #pulseaudio, #network, #custom-randwall, #custom-launcher {
	background: transparent;
	padding: 5px 5px 5px 5px;
	margin: 5px 5px 5px 5px;
  border-radius: 8px;
  border: solid 0px #f4d9e1;
}

#custom-date {
	color: #D3869B;
}

#custom-power {
	color: #24283b;
	background-color: #db4b4b;
	border-radius: 5px;
	margin-right: 10px;
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 0px;
	padding: 5px 10px;
}

#tray {
    background: #282828;
    margin: 5px 5px 5px 5px;
    border-radius: 16px;
    padding: 0px 5px;
    /*border-right: solid 1px #282738;*/
}

#clock {
    color: #E6B9C6;
    background-color: #282828;
    border-radius: 0px 0px 0px 24px;
    padding-left: 13px;
    padding-right: 15px;
    margin-right: 0px;
    margin-left: 10px;
    margin-top: 0px;
    margin-bottom: 0px;
    font-weight: bold;
    /*border-left: solid 1px #282738;*/
}


#battery {
    color: #9ece6a;
}

#battery.charging {
    color: #9ece6a;
}

#battery.warning:not(.charging) {
    background-color: #f7768e;
    color: #24283b;
    border-radius: 5px 5px 5px 5px;
}

#backlight {
    background-color: #24283b;
    color: #db4b4b;
    border-radius: 0px 0px 0px 0px;
    margin: 5px;
    margin-left: 0px;
    margin-right: 0px;
    padding: 0px 0px;
}

#network {
    color: #f4d9e1;
    border-radius: 8px;
    margin-right: 5px;
}

#pulseaudio {
    color: #f4d9e1;
    border-radius: 8px;
    margin-left: 0px;
}

#pulseaudio.muted {
    background: transparent;
    color: #928374;
    border-radius: 8px;
    margin-left: 0px;
}

#custom-randwall {
    color: #f4d9e1;
    border-radius: 8px;
    margin-right: 0px;
}

#custom-launcher {
    color: #E6B9C6;
    background-color: #282828;
    border-radius: 0px 0px 24px 0px;
    margin: 0px 0px 0px 0px;
    padding: 0 20px 0 13px;
    /*border-right: solid 1px #282738;*/
    font-size: 20px;
}

#custom-launcher button:hover {
    background-color: #FB4934;
    color: transparent;
    border-radius: 8px;
    margin-right: -5px;
    margin-left: 10px;
}

#custom-playerctl {
	background: #282828;
	padding-left: 15px;
  padding-right: 14px;
	border-radius: 16px;
  /*border-left: solid 1px #282738;*/
  /*border-right: solid 1px #282738;*/
  margin-top: 5px;
  margin-bottom: 5px;
  margin-left: 0px;
  font-weight: normal;
  font-style: normal;
  font-size: 16px;
}

#custom-playerlabel {
    background: transparent;
    padding-left: 10px;
    padding-right: 15px;
    border-radius: 16px;
    /*border-left: solid 1px #282738;*/
    /*border-right: solid 1px #282738;*/
    margin-top: 5px;
    margin-bottom: 5px;
    font-weight: normal;
    font-style: normal;
}

#window {
    background: #282828;
    padding-left: 15px;
    padding-right: 15px;
    border-radius: 16px;
    /*border-left: solid 1px #282738;*/
    /*border-right: solid 1px #282738;*/
    margin-top: 5px;
    margin-bottom: 5px;
    font-weight: normal;
    font-style: normal;
}

#custom-wf-recorder {
    padding: 0 20px;
    color: #e5809e;
    background-color: #1E1E2E;
}

#cpu {
    background-color: #282828;
    /*color: #FABD2D;*/
    border-radius: 16px;
    margin: 5px;
    margin-left: 5px;
    margin-right: 5px;
    padding: 0px 10px 0px 10px;
    font-weight: bold;
}

#memory {
    background-color: #282828;
    /*color: #83A598;*/
    border-radius: 16px;
    margin: 5px;
    margin-left: 5px;
    margin-right: 5px;
    padding: 0px 10px 0px 10px;
    font-weight: bold;
}

#disk {
    background-color: #282828;
    /*color: #8EC07C;*/
    border-radius: 16px;
    margin: 5px;
    margin-left: 5px;
    margin-right: 5px;
    padding: 0px 10px 0px 10px;
    font-weight: bold;
}

#custom-hyprpicker {
    background-color: #282828;
    /*color: #8EC07C;*/
    border-radius: 16px;
    margin: 5px;
    margin-left: 5px;
    margin-right: 5px;
    padding: 0px 11px 0px 9px;
    font-weight: bold;
}
      '';
    };

    programs.anyrun = {
      enable = true;

      config = {
	x = { fraction = 0.5; };
	y = { fraction = 0.25; };
	width = { absolute = 800; };
	height = { absolute = 1; };
	layer = "overlay";
	closeOnClick = true;

	plugins = [
	  "${pkgs.anyrun}/lib/libapplications.so"
          "${pkgs.anyrun}/lib/librink.so"
	  "${pkgs.anyrun}/lib/libshell.so"
	];
      };


      extraCss = "
	  window {
 	    background: transparent;
	  }

	  box.main {
  	    padding: 5px;
  	    margin: 10px;
  	    border-radius: 10px;
  	    border: 2px solid @theme_selected_bg_color;
  	    background-color: @theme_bg_color;
  	    box-shadow: 0 0 5px black;
  	    font-family: \"JetBrainsMonoNL Nerd Font\", monospace;
  	    font-size: 18px;
	  }


	  text {
  	    min-height: 30px;
  	    padding: 5px;
  	    border-radius: 5px;
	  }

	  .matches {
  	    background-color: rgba(0, 0, 0, 0);
  	    border-radius: 10px;
	  }

	  box.plugin:first-child {
  	    margin-top: 5px;
	  }

	  box.plugin.info {
  	    min-width: 200px;
	  }

	  list.plugin {
  	    background-color: rgba(0, 0, 0, 0);
	  }

	  label.match.description {
  	    font-size: 14px;
	  }

	  label.plugin.info {
  	    font-size: 14px;
	  }

	  .match {
  	    background: transparent;
	  }

	  .match:selected {
  	    border-left: 4px solid @theme_selected_bg_color;
  	    background: transparent;
  	    animation: fade 0.1s linear;
	  }

	  @keyframes fade {
  	    0% {
    	    opacity: 0;
  	  }

  	  100% {
    	    opacity: 1;
  	  }
	}
	";
    };

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
	exec-once = [
	  "waybar"
	  "swww-daemon"
	];

        monitor = [
          "DP-3, 2560x1440@144, 1920x0, 1.25" 
          "DP-2, 1920x1080@60, 0x0, 1"
        ];

        "$terminal" = "hyprctl dispatch exec '[float; size 1000 510]' kitty";
        "$fileManager" = "dolphin";
        "$menu" = "anyrun";

	general = {
	  gaps_in = "3";
	  gaps_out = "7";

	  border_size = "2";

	  "col.active_border" = "rgba(ffc8ddee) rgba(cdb4dbee) 45deg";
	  "col.inactive_border" = "rgba(595959aa)";

	  layout = "dwindle";
	};

	decoration = {
	  rounding = "10";
	  active_opacity = "1.0";
	  inactive_opacity = "1.0";

	  shadow = {
	    enabled = true;
	    range = "4";
	    render_power = "3";
	    color = "rgba(1a1a1aee)";
	  };

	  blur = {
	    enabled = true;
	    size = "3";
	    passes = "1";

	    vibrancy = "0.1696";
	  };
	};

	dwindle = {
	  pseudotile = true;
	  preserve_split = true;
	};

	master = {
	  new_status = "master";
	};

	misc = {
	  force_default_wallpaper = "1";
	  disable_hyprland_logo = true;
	};

	input = {
	  kb_layout = "us";
	  kb_variant = "";
	  kb_model = "";
	  kb_options = "";
	  kb_rules = "";

	  follow_mouse = "1";

	  sensitivity = "-0.6";
	};

	"$mainMod" = "SUPER";

        bind = [
          "$mainMod, Q, exec, $terminal"
	  "$mainMod, C, killactive,"
	  "$mainMod SHIFT, C, exec, kill -9 $(hyprctl activewindow -j | jq -r '.pid')"
	  "$mainMod, M, exit,"
	  "$mainMod, E, exec, $filemanager"
	  "$mainMod, V, togglefloating,"
	  "$mainMod, R, exec, $menu"
	  "$mainMod, P, pseudo,"
	  "$mainMod, J, togglesplit,"
	  "$mainMod, L, exec, hyprlock"
	  "$mainMod, F, fullscreen"

	  "$mainMod, left, movefocus, l"
	  "$mainMod, right, movefocus, r"
	  "$mainMod, up, movefocus, u"
	  "$mainMod, down, movefocus, d"

	  "$mainMod, 1, workspace, 1"
	  "$mainMod, 2, workspace, 2"
	  "$mainMod, 3, workspace, 3"
	  "$mainMod, 4, workspace, 4"
	  "$mainMod, 5, workspace, 5"
	  "$mainMod, 6, workspace, 6"
	  "$mainMod, 7, workspace, 7"
	  "$mainMod, 8, workspace, 8"
	  "$mainMod, 9, workspace, 9"
	  "$mainMod, 0, workspace, 10"

	  "$mainMod SHIFT, 1, movetoworkspace, 1"
	  "$mainMod SHIFT, 2, movetoworkspace, 2"
	  "$mainMod SHIFT, 3, movetoworkspace, 3"
	  "$mainMod SHIFT, 4, movetoworkspace, 4"
	  "$mainMod SHIFT, 5, movetoworkspace, 5"
	  "$mainMod SHIFT, 6, movetoworkspace, 6"
	  "$mainMod SHIFT, 7, movetoworkspace, 7"
	  "$mainMod SHIFT, 8, movetoworkspace, 8"
	  "$mainMod SHIFT, 9, movetoworkspace, 9"
	  "$mainMod SHIFT, 0, movetoworkspace, 10"

	  "$mainMod SHIFT, LEFT, swapwindow, l"
	  "$mainMod SHIFT, RIGHT, swapwindow, r"
	  "$mainMod SHIFT, UP, swapwindow, u"
	  "$mainMod SHIFT, DOWN, swapwindow, d"

	  "$mainMod, Z, exec, amixer set Capture toggle"

	  "$mainMod SHIFT, mouse_down, exec, rmpc volume +5"
	  "$mainMod SHIFT, mouse_up, exec, rmpc volume -5"
	  ", code:164, exec, rmpc togglepause"

	  "$mainMod, x, exec, hyprshot -m region --clipboard-only"
	  "$mainMod SHIFT, x, exec, hyprshot -m window --clipboard-only"
	  "$mainMod ALT_L, x, exec, hyprshot -m output --clipboard-only"
        ];

	bindm = [
	  "$mainMod, mouse:272, movewindow"
	  "$mainMod, mouse:273, resizewindow"
	];

	bindel = [
	  ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
	  ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	  ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
	  ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
	  ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
	  ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
	];

	bindl = [
	  ",XF86AudioNext, exec, playerctl next"
	  ",XF86AudioPause, exec, playerctl play-pause"
	  ",XF86AudioPlay, exec, playerctl play-pause"
	  ",XF86AudioPrev, exec, playerctl previous"
	];

	xwayland = {
	  force_zero_scaling = true;
	};
      };

    # oh great heavens this is awful
    extraConfig = ''
	animations {
    		enabled = yes, please :)

    	# Default animations, see https://wiki.hypr.land/Configuring/Animations/ for more

    		bezier = easeOutQuint,0.23,1,0.32,1
    		bezier = easeInOutCubic,0.65,0.05,0.36,1
    		bezier = linear,0,0,1,1
    		bezier = almostLinear,0.5,0.5,0.75,1.0
    		bezier = quick,0.15,0,0.1,1

    		animation = global, 1, 10, default
    		animation = border, 1, 5.39, easeOutQuint
    		animation = windows, 1, 4.79, easeOutQuint
    		animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
    		animation = windowsOut, 1, 1.49, linear, popin 87%
    		animation = fadeIn, 1, 1.73, almostLinear
    		animation = fadeOut, 1, 1.46, almostLinear
    		animation = fade, 1, 3.03, quick
    		animation = layers, 1, 3.81, easeOutQuint
    		animation = layersIn, 1, 4, easeOutQuint, fade
    		animation = layersOut, 1, 1.5, linear, fade
    		animation = fadeLayersIn, 1, 1.79, almostLinear
    		animation = fadeLayersOut, 1, 1.39, almostLinear
    		animation = workspaces, 1, 1.94, almostLinear, fade
    		animation = workspacesIn, 1, 1.21, almostLinear, fade
    		animation = workspacesOut, 1, 1.94, almostLinear, fade
	}


	# Ignore maximize requests from apps. You'll probably like this.
	windowrule = suppressevent maximize, class:.*

	# Fix some dragging issues with XWayland
	windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

	# fix hyprshot black border
	layerrule = noanim, hyprpicker
	layerrule = noanim, selection

	# fix picture in picture
	windowrulev2 = float, title:^(Picture-in-Picture)$
	windowrulev2 = pin, title:^(Picture-in-Picture)$
    '';
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
      (import ./modules/util/musicpresence.nix { inherit pkgs; })
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
  users.users.ashley = {
    isNormalUser = true;
    description = "ashley";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
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
  playerctl
  xdg-utils
  wl-clipboard
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

  systemd.user.services.musicpresence = {
    description = "discord music presence";
    # this is awful, i hate this, but im stupid and cant come up with a better solution
    serviceConfig.ExecStart = "${(pkgs.callPackage ./modules/util/musicpresence.nix {})}/bin/musicpresence";
    wantedBy = [ "default.target" ];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    nvidiaSettings = true;
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
