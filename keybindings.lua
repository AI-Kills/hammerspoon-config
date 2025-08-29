-- Carica i file dalla cartella Spoons
require("Spoons.cursor")
require("Spoons.warp")

-- Carica e avvia il modulo temp-keybindings
local tempKeybindings = require("Spoons.temp-keybindings")
tempKeybindings:init()

-- Carica il modulo per Chrome hotkeys
local chrome_hotkeys = require("Spoons.chrome_hotkeys")

hs.hotkey.bind({ "alt" }, "escape", function()
	focus_on_cursor_window()
end)

hs.hotkey.bind({ "cmd" }, "escape", function()
	sw()
end)

-- Carica il modulo per riprendere pagine Chrome
require("Spoons.resume_chrome_page")

-- Carica il modulo per le lettere greche
require("Spoons.keys_substitutions")

-- Attiva il toggle dei devtools di Chrome con il tasto ù
chrome_hotkeys.open_dev_tools_shortcut()
