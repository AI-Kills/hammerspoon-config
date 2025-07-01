-- Enable IPC for command-line access
hs.ipc.cliInstall()
hs.application.enableSpotlightForNameSearches(true)

require("keybindings")
require("utils.apps_utils")

-- Carica il modulo per riprendere pagine Chrome
require("Spoons.resume_chrome_page")

-- uno può definirsi delle funzioni che possono essere richiamate nella hs cli
function reload()
	hs.reload()
	hs.alert.show("Config loaded")
end

hs.alert.show("Config loaded")
