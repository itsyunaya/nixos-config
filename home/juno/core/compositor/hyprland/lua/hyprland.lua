
function import(module)
	local status, _ = pcall(require, module)
	if not status then
		hl.exec_cmd("notify-send -u critical \"Hyprland\" \"Failed to load the following module: " .. module .. "\"")
		return 1
	end
	return 0
end

import("animations")
import("binds")
import("config")
import("events")
import("monitors")
import("rules")
