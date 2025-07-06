-- Carica i file dalla cartella Spoons
require("Spoons.cursor")
require("Spoons.warp")

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
