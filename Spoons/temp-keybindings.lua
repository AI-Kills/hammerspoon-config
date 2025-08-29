local obj = {}

-- Metadata
obj.name = "TempKeybindings"
obj.author = "AI"

-- Variables
obj.isActive = false
obj.modal = nil
obj.sequenceBuffer = ""
obj.sequenceTimer = nil

local temp_keybindings_mapping = {
	{ "h", "tab" },
	-- { "k", "/" },
}

-- Initialize the spoon
function obj:init()
	-- Create modal for temp keybindings
	self.modal = hs.hotkey.modal.new()

	-- Setup activation hotkey (Cmd+Y)
	hs.hotkey.bind({ "cmd" }, "h", function()
		self:toggleTempMode()
	end)

	-- Setup temp keybindings
	self:setupTempKeybindings()

	return self
end

-- Setup temporary keybindings
function obj:setupTempKeybindings()
	-- bind the keybinings in
	for _, pair in ipairs(temp_keybindings_mapping) do
		local _x, x_ = pair[1], pair[2]
		self.modal:bind({}, _x, function()
			hs.eventtap.keyStroke({}, x_)
		end)
	end

	-- TODO: generalize in the keybinding mapping
	self.modal:bind({}, "y", function()
		hs.eventtap.keyStroke({ "cmd" }, "right")
	end)
end

-- Toggle temp mode on/off
function obj:toggleTempMode()
	if self.isActive then -- deactivate mode
		self.isActive = false
		self.modal:exit()
		hs.alert.show("❌ Temp Keybindings: OFF", 1)
		print("Temp keybindings mode deactivated")
	else -- activate mode
		self.isActive = true
		self.modal:enter()
		hs.alert.show("🔥 Temp Keybindings: ON\n(h→tab, r→commad + right arrow, command Y to exit)", 2)
		print("Temp keybindings mode activated")
	end
end

return obj
