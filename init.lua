-- Enable IPC for command-line access
hs.ipc.cliInstall()

-- uno può definirsi delle funzioni che possono essere richiamate nella hs cli
function reload()
	hs.reload()
	hs.alert.show("Config loaded")
end

hs.hotkey.bind({ "cmd", "." }, ".", function() -- combinazione command + . per ricaricare config
	reload()
end)

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

hs.hotkey.bind({ "alt" }, "escape", function()
	open_cursor()
end)


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

hs.hotkey.bind({ "cmd" }, "escape", function()
	sw()
end)



hs.alert.show("Config loaded")
