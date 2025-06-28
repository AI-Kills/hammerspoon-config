-- Carica i file dalla cartella Spoons
require("Spoons.cursor")
require("Spoons.warp")

hs.hotkey.bind({ "alt" }, "escape", function()
	open_cursor()
end)

hs.hotkey.bind({ "cmd" }, "escape", function()
	sw()
end)
