-- Enable IPC for command-line access
hs.ipc.cliInstall()

-- uno può definirsi delle funzioni che possono essere richiamate nella hs cli
function reload()
	hs.reload()
	hs.alert.show("Config loaded")
end

hs.hotkey.bind({ "cmd", "+" }, "+", function() -- combinazione command + r r per ricaricare config
	reload()
end)

function sw()
	local warpApp = hs.application.find("Warp")
	if not warpApp then
		--	print("warp is not running")
		return
	end

	local windows = warpApp:allWindows()
	if #windows == 0 then
		--	print("No warp windows found")
		return
	end

	local found = false
	--	print("Finestre trovate: " .. #windows)

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

	if not found then
		--	print("Nessuna finestra corrispondente trovata per: " .. window_title)
	end
end

hs.hotkey.bind({ "cmd" }, "escape", function()
	sw()
end)

hs.alert.show("Config loaded")
