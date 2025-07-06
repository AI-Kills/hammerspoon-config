-- RaycastClipboard Spoon
local RaycastClipboard = {}

-- Inizializza la spoon
function RaycastClipboard:init()
	-- Variabile per tracciare il numero selezionato
	self.selectedNumber = nil

	-- Crea il modal SENZA hotkey automatico
	self.modal = hs.hotkey.modal.new()

	-- Definisci i bind del modal SUBITO dopo la creazione
	-- Bind per i numeri 1-9
	for i = 1, 9 do
		self.modal:bind({}, tostring(i), function()
			self.selectedNumber = i
			hs.alert.show("Selezionato numero: " .. i .. " - ora premi cmd+v")
		end)
	end

	-- Bind per cmd+v
	self.modal:bind({ "cmd" }, "v", function()
		if self.selectedNumber then
			hs.alert.show("Azione per numero " .. self.selectedNumber .. "!")
			-- Qui puoi aggiungere la logica specifica per ogni numero
			-- Ad esempio:
			-- if self.selectedNumber == 1 then
			--     -- fai qualcosa per il numero 1
			-- elseif self.selectedNumber == 2 then
			--     -- fai qualcosa per il numero 2
			-- end
		else
			hs.alert.show("Nessun numero selezionato!")
		end
		self.selectedNumber = nil -- Reset
		self.modal:exit()
	end)

	-- Bind ESC per uscire dal modal
	self.modal:bind({}, "escape", function()
		self.selectedNumber = nil -- Reset
		self.modal:exit()
	end)

	-- Crea un hotkey separato per ATTIVARE il modal
	self.trigger = hs.hotkey.bind({ "cmd" }, "h", function()
		hs.alert.show("Modal attivo: premi numero (1-9) poi cmd+v")
		self.selectedNumber = nil -- Reset quando si attiva
		self.modal:enter()
	end)

	return self
end

-- Avvia la spoon
function RaycastClipboard:start()
	-- Il modal è già configurato, non serve fare altro
	return self
end

-- Ferma la spoon
function RaycastClipboard:stop()
	if self.modal then
		self.modal:exit()
	end
	return self
end

-- Restituisce l'oggetto RaycastClipboard
return RaycastClipboard
