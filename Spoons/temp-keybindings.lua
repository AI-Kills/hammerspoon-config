local obj = {}

-- Metadata
obj.name = "TempKeybindings"
obj.author = "AI"

-- Variables
obj.isActive = false
obj.modal = nil
obj.sequenceBuffer = ""
obj.sequenceTimer = nil

-- Mapping configuration with type distinction
-- type: "key" for key substitution, "string" for string substitution
local temp_keybindings_mapping = {
	{ key = "h", action = "tab", type = "key" },
	{ key = "r", action = 'hs -c "reload()"', type = "string" },
	{ key = "s", action = 'hs -c "sw()"', type = "string" },
	{ key = "f", action = " | grep -E -i ", type = "string" },
	{ key = "l", action = "  | _", type = "string" },
	{ key = "x", action = ' | _x &&  "$x"', type = "string" },

	-- Examples:
	-- { key = "a", action = "Hello World!", type = "string" },
	-- { key = "j", action = "down", type = "key" },
	-- { key = "k", action = "up", type = "key" },
}

-- Initialize the spoon
function obj:init()
	-- Create modal for temp keybindings
	self.modal = hs.hotkey.modal.new()

	-- Setup activation hotkey (Cmd+H)
	hs.hotkey.bind({ "cmd" }, "h", function()
		self:toggleTempMode()
	end)

	-- Setup temp keybindings
	self:setupTempKeybindings()

	return self
end

-- Setup temporary keybindings
function obj:setupTempKeybindings()
	for _, mapping in ipairs(temp_keybindings_mapping) do
		local key = mapping.key
		local action = mapping.action
		local actionType = mapping.type

		self.modal:bind({}, key, function()
			if actionType == "key" then
				self:handleKeySubstitution(action)
			elseif actionType == "string" then
				self:handleStringSubstitution(action)
			end
		end)
	end
end

-- Handle key substitution
function obj:handleKeySubstitution(action)
	if type(action) == "string" then
		-- Simple key stroke
		hs.eventtap.keyStroke({}, action)
	elseif type(action) == "table" then
		-- Key stroke with modifiers
		local modifiers = {}
		local key = action[#action] -- Last element is the key

		-- All elements except the last are modifiers
		for i = 1, #action - 1 do
			table.insert(modifiers, action[i])
		end

		hs.eventtap.keyStroke(modifiers, key)
	end
end

-- Handle string substitution
function obj:handleStringSubstitution(text)
	-- Type the string directly
	hs.eventtap.keyStrokes(text)
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

		-- Generate dynamic alert message based on current mappings
		local alertMessage = "🔥 Temp Keybindings: ON\n"
		for _, mapping in ipairs(temp_keybindings_mapping) do
			local actionDesc = ""
			if mapping.type == "key" then
				if type(mapping.action) == "string" then
					actionDesc = mapping.action
				else
					actionDesc = table.concat(mapping.action, "+")
				end
			else
				actionDesc = "'" .. mapping.action .. "'"
			end
			alertMessage = alertMessage .. mapping.key .. "→" .. actionDesc .. ", "
		end
		alertMessage = alertMessage .. "Cmd+H to exit"

		hs.alert.show(alertMessage, 3)
		print("Temp keybindings mode activated")
	end
end

return obj
