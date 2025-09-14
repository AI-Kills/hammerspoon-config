-- Carica i file dalla cartella Spoons
require("Spoons.cursor")
require("Spoons.warp")

-- Carica e avvia il modulo temp-keybindings
local tempKeybindings = require("Spoons.temp-keybindings")
tempKeybindings:init()

-- Carica il modulo per Chrome hotkeys
local chrome_hotkeys = require("Spoons.chrome_hotkeys")

hs.hotkey.bind({ "alt" }, "escape", function()
	local cmd = [[open -a "cursor"]]
	hs.task
		.new(
			"/bin/zsh",
			function(exitCode, stdout, stderr)
				hs.notify
					.new({
						title = "Shell task",
						informativeText = ("exit=%d\n%s%s"):format(exitCode, stdout, stderr),
						withdrawAfter = 3,
					})
					:send()
			end,
			{ "-lc", cmd } -- -l = login: carica ~/.zprofile; -c = esegui comando
		)
		:start()
end)

-- Carica il modulo per riprendere pagine Chrome
require("Spoons.resume_chrome_page")

-- Carica il modulo per le lettere greche
require("Spoons.keys_substitutions")

-- Attiva il toggle dei devtools di Chrome con il tasto ù
chrome_hotkeys.open_dev_tools_shortcut()

-- Attiva la funzione sw quando si preme command + spazio
hs.hotkey.bind({ "cmd" }, "escape", function()
	sw()
end)

--  Φaggiungi che µ (equivalente a option m ) corrisponda alla sostituzione della stringa
--  "$()" con il cursore che si mette tra le parentesi
