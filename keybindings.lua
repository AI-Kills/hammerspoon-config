-- Carica i file dalla cartella Spoons
require("Spoons.cursor")
require("Spoons.warp")

-- cmd + . per reload
hs.hotkey.bind({ "cmd", "." }, ".", function()
	reload()
end)

hs.hotkey.bind({ "alt" }, "escape", function()
	open_cursor()
end)

hs.hotkey.bind({ "cmd" }, "escape", function()
	sw()
end)

hs.hotkey.bind({ "alt", "." }, ".", function()
	write_prompt()
end)
