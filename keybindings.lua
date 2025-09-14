require("Spoons.cursor")
require("Spoons.warp")

local tempKeybindings = require("Spoons.temp-keybindings") -- Carica e avvia il modulo temp-keybindings
tempKeybindings:init()

local chrome_hotkeys = require("Spoons.chrome_hotkeys") -- Carica il modulo per Chrome hotkeys

hs.hotkey.bind({ "alt" }, "escape", function() -- apre cursor con option escape
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

require("Spoons.resume_chrome_page") -- apre la pagina chrome con cmd y
require("Spoons.keys_substitutions") -- Carica il modulo per le lettere greche
chrome_hotkeys.open_dev_tools_shortcut() -- Attiva il toggle dei devtools di Chrome con il tasto ù
hs.hotkey.bind({ "cmd" }, "escape", function()
	-- switch between warp instances
	-- Attiva la funzione sw quando si preme command + spazio
	sw()
end)

-- # custom substitutions
-- # bash
hs.hotkey.bind({ "alt" }, "m", function()
	-- Aggiunge sostituzione per µ (option+m): inserisce "$())" con cursore tra parentesi
	hs.eventtap.keyStrokes([["$()"]]) -- literal: "$()"
	hs.eventtap.keyStroke({}, "left")
	hs.eventtap.keyStroke({}, "left")
end)
