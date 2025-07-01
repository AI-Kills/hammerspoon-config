require("utils.apps_utils")
-- Nome dell'applicazione
local appName = "Cursor"

-- Funzione per spostare finestre
function move_to_main_screen()
	local app = hs.application.find(appName)
	if not app then
		return
	end

	-- Ottieni tutte le finestre
	local windows = app:allWindows()
	if #windows == 0 then
		return
	end

	-- Ottieni lo schermo principale
	local primaryScreen = hs.screen.primaryScreen()

	-- Sposta ciascuna finestra sullo schermo principale
	for _, win in ipairs(windows) do
		win:moveToScreen(primaryScreen, true, true)
		win:focus()
	end
end

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

function write_prompt_in_cursor_instance(args)
	local prompt = args.prompt
	local window_title = args.window_title
	print(window_title)

	focus_app_window({
		app_name = "cursor",
		window_title = window_title,
		print_info = true,
	})
	hs.timer.doAfter(2, function()
		hs.eventtap.keyStroke({ "cmd", "I" }, "I")

		hs.timer.doAfter(0.2, function()
			hs.eventtap.keyStrokes(prompt) -- write the prompt in cursor
			hs.timer.doAfter(0.3, function()
				hs.eventtap.keyStroke({}, "return")
			end)
		end)
	end)

	-- Add a small delay to ensure the text is fully processed
end

function write_prompt_in_cursor_instance_for_background_agent(args)
	local window_title = args.window_title
	local prompt = args.prompt
	local open_cloud_modal = args.open_cloud_modal

	focus_app_window({
		app_name = "cursor",
		window_title = window_title,
	})

	-- Se open_cloud_modal è true, premi Cmd+E
	hs.timer.doAfter(2, function()
		hs.eventtap.keyStroke({ "cmd", "E" }, "E")
		hs.timer.doAfter(1, function()
			hs.eventtap.keyStroke({ "cmd", "E" }, "E")

			hs.timer.doAfter(0.2, function()
				hs.eventtap.keyStrokes(prompt) -- write the prompt in cursor
				hs.timer.doAfter(0.3, function()
					hs.eventtap.keyStroke({}, "return")
				end)
			end)
		end)
	end)
end
