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

function write_prompt_in_cursor_instance(args)
	local window_title = args.window_title
	local prompt = args.prompt
	focus_app_window({
		app_name = "cursor",
		window_title = window_title,
	})
	hs.eventtap.keyStrokes(prompt) -- write the prompt in cursor
	hs.eventtap.keyStroke({ "cmd" }, "enter") -- press enter
end
