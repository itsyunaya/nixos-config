{ ... }:

{
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
	  						"fedora": "\uF30a FEDR",
	  						"nixos": "\uF313 NIXS"
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
}
