-- Resume Chrome Page Automation
-- Simula una sequenza di tasti per riprendere una pagina Chrome

local M = {}

-- Variabile per memorizzare il hotkey
local hotkey = nil

-- Funzione per simulare la sequenza di tasti
function M.resume()
	-- Comando 1: Command + Y
	hs.eventtap.keyStroke({ "cmd" }, "y")

	-- Piccolo delay per assicurarsi che il comando sia processato
	hs.timer.usleep(50000) -- 0.05 secondi

	-- Comando 2: Command + L
	hs.eventtap.keyStroke({ "cmd" }, "l")

	hs.timer.usleep(50000)

	-- Comando 3: Command + C
	hs.eventtap.keyStroke({ "cmd" }, "c")

	hs.timer.usleep(50000)

	-- Comando 4: Command + , (virgola)
	hs.eventtap.keyStroke({ "cmd" }, ",")

	-- Pausa di 0.4 secondi prima del prossimo comando
	hs.timer.doAfter(0.4, function()
		-- Comando 5: Command + N
		hs.eventtap.keyStroke({ "cmd" }, "n")

		-- Pausa di 0.3 secondi prima degli ultimi comandi
		hs.timer.doAfter(0.3, function()
			-- Comando 6: Command + V
			hs.eventtap.keyStroke({ "cmd" }, "v")
			hs.eventtap.keyStrokes(
				"riassui il contenuto della pagina in modo breve e schematico. risparmiamo parole inutili"
			) -- write the prompt in cursor

			-- Piccolo delay prima di premere Enter
			hs.timer.usleep(50000)

			-- Comando 7: Enter
			hs.eventtap.keyStroke({}, "return")
		end)
	end)
end

-- Funzione per inizializzare il modulo e configurare il hotkey
function M.init()
	-- Configura il hotkey: Command + < per attivare la funzione resume
	hotkey = hs.hotkey.bind({ "cmd" }, "-", function()
		print("Resume Chrome Page: Attivato hotkey Command+<")
		M.resume()
	end)

	print("Resume Chrome Page: Hotkey configurato (Command+<)")
end

-- Funzione per disattivare il modulo
function M.stop()
	if hotkey then
		hotkey:delete()
		hotkey = nil
		print("Resume Chrome Page: Hotkey disattivato")
	end
end

-- Funzione per riavviare il modulo
function M.start()
	M.stop()
	M.init()
end

-- Funzione di utilità per stampare un messaggio di conferma
function M.test()
	print("Resume Chrome Page: funzione attivata manualmente")
	M.resume()
end

-- Inizializza automaticamente il modulo quando viene caricato
M.init()

return M
