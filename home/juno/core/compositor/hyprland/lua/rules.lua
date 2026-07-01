
hl.window_rule({
	match = { class = ".*" },
	suppress_event = "maximize"
})

hl.window_rule({
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false
	},
	no_focus = true
})

hl.window_rule({
	match = { title = "^(Picture-in-Picture)$" },
	float = true,
	pin = true
})

hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
