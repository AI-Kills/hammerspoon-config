-- keyboard shortcuts in chrome:
--
-- - u accentata per toggle dev tools
--
--
local M = {}

-- Config: tasto e bundle ID (Chrome/Brave/Edge opzionali)
M.key = 42 -- keycode per il tasto ù sulla tastiera italiana
M.chromeBundles = {
	["com.google.Chrome"] = true,
	-- ["com.brave.Browser"] = true,
	-- ["com.microsoft.edgemac"] = true,
}

local hotkeyHandle

function M.open_dev_tools_shortcut(key)
	-- permette override: M.open_dev_tools_shortcut(42) o altro keycode
	key = key or M.key

	-- rimuovi bind precedente se esiste
	if hotkeyHandle then
		hotkeyHandle:delete()
		hotkeyHandle = nil
	end

	hotkeyHandle = hs.hotkey.bind({}, key, function()
		local app = hs.application.frontmostApplication()
		if app and M.chromeBundles[app:bundleID()] then
			-- Invia Cmd+Alt+J alla finestra frontmost di quell'app
			hs.eventtap.keyStroke({ "cmd", "alt" }, "j", 0, app)
		end
	end)

	return true
end

return M
