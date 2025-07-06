-- RaycastClipboard Spoon
local RaycastClipboard = {}

-- Inizializza la spoon
function RaycastClipboard:init()
	-- Crea il modal SENZA hotkey automatico
	self.modal = hs.hotkey.modal.new()

	-- Definisci i bind del modal SUBITO dopo la creazione
	-- Bind del tasto A
	self.modal:bind({}, "a", function()
		hs.alert.show("uuu")
		self.modal:exit()
	end)
	
	-- Bind ESC per uscire dal modal
	self.modal:bind({}, "escape", function()
		self.modal:exit()
	end)

	-- Crea un hotkey separato per ATTIVARE il modal
	self.trigger = hs.hotkey.bind({ "cmd" }, "h", function()
		hs.alert.show("Modal attivo: premi a per azione")
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
