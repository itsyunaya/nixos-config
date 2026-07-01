
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
		middle_click_paste = false,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 1,
	},

	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},

	animations = { enabled = true },
	master = { new_status = "master", },
	xwayland = { force_zero_scaling = true }
})
