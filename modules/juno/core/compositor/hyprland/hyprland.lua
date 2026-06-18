
hl.config({
	general = {
		border_size = 2,
		gaps_in = 3,
		gaps_out = 7,
		layout = "dwindle",

		col = {
			active_border = { colors = { "rgba(ffc8ddee)", "rgba(cdb4dbee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
	},

	decoration = {
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		rounding = 10,

		blur = {
			enabled = true,
			passes = 1,
			size = 3,
			vibrancy = 0.1696,
		},

		shadow = {
			enabled = true,
			color = "rgba(1a1a1aee)",
			range = 4,
			render_power = 3,
		},
	},

	input = {
		follow_mouse = 1,
		kb_layout = "us",
		sensitivity = -0.6,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 1,
	},

	animations = { enabled = true },
	master = { new_status = "master", },
	xwayland = { force_zero_scaling = true }
})

hl.monitor({
	output = "DP-3",
	mode = "2560x1440@144",
	position = "1920x0",
	scale = 1.25,
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
})

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("awww-daemon")
	-- TODO: unhardcode this path
	hl.exec_cmd("awww img /home/ashley/sysflake/assets/wallpapers/clouds.jpg")
	hl.exec_cmd("mpd-mpris")
	hl.exec_cmd("yams")
	hl.exec_cmd("musicpresence")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("anyrun daemon")
	hl.exec_cmd("playerctld")
	hl.exec_cmd("xwl-notifier")
end)

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

for i = 0, 9 do
	local ws_id = (i == 0) and 10 or i
	local key = tostring(i)

	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = ws_id }))
end

hl.bind("SUPER + Q", hl.dsp.exec_cmd("kitty", { float = true, size = { 1000, 510 } }))
hl.bind("SUPER + E", hl.dsp.exec_cmd("dolphin"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("anyrun"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + C", hl.dsp.window.kill())
hl.bind("SUPER + V", hl.dsp.window.float())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())

hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.swap({ direction = "d" }))

hl.bind("SUPER + Z", hl.dsp.exec_cmd("amixer set Capture toggle"))
hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.exec_cmd("rmpc volume +5"))
hl.bind("SUPER + SHIFT + mouse_up", hl.dsp.exec_cmd("rmpc volume -5"))
hl.bind("code:164", hl.dsp.exec_cmd("rmpc togglepause"))

hl.bind("SUPER + X", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind("SUPER + SHIFT + X", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind("SUPER + ALT_L + X", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true, locked = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
