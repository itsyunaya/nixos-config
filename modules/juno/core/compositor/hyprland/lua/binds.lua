
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
