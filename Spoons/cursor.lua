require("utils.apps_utils")

function open_cursor()
	local cursorApp = hs.application.find("cursor")
	if not cursorApp then
		print("cursor is not running")
		return
	end

	local windows = cursorApp:allWindows()

	if #windows == 0 then
		print("No warp windows found")
		return
	end

	if #windows == 1 then -- if there is only one window, focus on it
		windows[1]:focus()
		return
	end
end

function write_prompt()
	print("Avvio controllo finestre di Cursor...")

	local cursorApp = hs.application.find("cursor")
	if not cursorApp then
		print("Cursor non è in esecuzione.")
		return
	end

	local windows = cursorApp:allWindows()

	if #windows == 0 then
		print("Nessuna finestra trovata.")
		return
	end

	for i, win in ipairs(windows) do
		print("---- Finestra #" .. i .. " ----")
		print("Titolo: " .. win:title())
		print("ID: " .. win:id())
		print("Ruolo: " .. (win:role() or "N/A"))
		local frame = win:frame()
		print(string.format("Frame: x=%d y=%d w=%d h=%d", frame.x, frame.y, frame.w, frame.h))
	end
end
