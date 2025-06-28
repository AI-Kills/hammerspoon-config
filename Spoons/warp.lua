-- switch warp window
function sw()
	local warpApp = hs.application.find("Warp")
	if not warpApp then
		print("warp is not running")
		return
	end

	local windows = warpApp:allWindows()

	if #windows == 0 then
		print("No warp windows found")
		return
	end

	if #windows == 1 then -- if there is only one window, focus on it
		windows[1]:focus()
		return
	end

	-- else switch among the windows

	local found = false
	local i = 0

	for _, window in ipairs(windows) do
		--	print("Controllando finestra: " .. window:title())
		i = i + 1
		if i == 2 then
			window:focus()
			found = true
			break -- Esci dal ciclo dopo aver trovato la finestra
		end
	end
end
