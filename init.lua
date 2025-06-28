-- Enable IPC for command-line access
hs.ipc.cliInstall()

require("keybindings")

-- uno può definirsi delle funzioni che possono essere richiamate nella hs cli
function reload()
	hs.reload()
	hs.alert.show("Config loaded")
end

-- cmd + . per reload
hs.hotkey.bind({ "cmd", "." }, ".", function()
	reload()
end)

hs.alert.show("Config loaded")
