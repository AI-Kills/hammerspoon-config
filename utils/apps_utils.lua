function focus_app_window(args)
	local app_name = args.app_name
	local window_title = args.window_title
	local print_info = args.print_info

	local app = hs.application.find(app_name)
	if not app then
		print(app_name .. " non è in esecuzione.")
		return false
	end

	local windows = app:allWindows()
	local results = {}

	if #windows == 0 then
		print("Nessuna finestra trovata.")
		return false
	end

	if window_title then
		for i, win in ipairs(windows) do
			if print_info then
				print("---- Finestra #" .. i .. " ----")
				print("Titolo: " .. win:title())
				print("ID: " .. win:id())
				print("Ruolo: " .. (win:role() or "N/A"))
				local frame = win:frame()
				print(string.format("Frame: x=%d y=%d w=%d h=%d", frame.x, frame.y, frame.w, frame.h))
			end

			if string.find(win:title(), window_title, 1, true) then
				if print_info then
					print("Focus su finestra: " .. win:title())
				end
				win:focus()
				return true
			end

			table.insert(results, { titolo = win:title(), window = win })
		end

		print("Finestra con titolo '" .. window_title .. "' non trovata.")
		return results
	else
		for i, win in ipairs(windows) do
			if print_info then
				print("---- Finestra #" .. i .. " ----")
				print("Titolo: " .. win:title())
				print("ID: " .. win:id())
				print("Ruolo: " .. (win:role() or "N/A"))
				local frame = win:frame()
				print(string.format("Frame: x=%d y=%d w=%d h=%d", frame.x, frame.y, frame.w, frame.h))
			end

			-- Processa il titolo: se contiene "—", prendi solo la parte dopo
			local processed_title = win:title()
			local dash_pos = string.find(processed_title, "—")
			if dash_pos then
				-- Prendi la sottostringa dopo il "—" e rimuovi gli spazi iniziali
				processed_title = string.sub(processed_title, dash_pos + 1)
				processed_title = string.gsub(processed_title, "^%s*", "") -- Rimuovi spazi iniziali
				print("Processed title: " .. processed_title)
			end

			-- Inserisci la struttura nella lista
			table.insert(results, { titolo = processed_title, window = win })
		end

		return results
	end
end
