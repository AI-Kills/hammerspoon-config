function open_cursor()
	local cursorApp = hs.application.find("cursor")
	if not cursorApp then
		print("cursor is not running")
		return
	end

	local windows = cursorApp:allWindows()

	if #windows == 0 then
		print("No warp windows found")
		return
	end

	if #windows == 1 then -- if there is only one window, focus on it
		windows[1]:focus()
		return
	end
end
