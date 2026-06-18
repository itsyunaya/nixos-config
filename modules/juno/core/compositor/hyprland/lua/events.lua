
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
