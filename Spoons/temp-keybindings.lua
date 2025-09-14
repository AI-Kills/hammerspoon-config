local obj = {}

-- Metadata
obj.name = "TempKeybindings"
obj.author = "AI"

-- Variables
obj.isActive = false
obj.modal = nil
obj.sequenceBuffer = ""
obj.sequenceTimer = nil

-- Mapping configuration with action chains
-- Each mapping can have multiple actions executed in sequence
-- action format: { type = "key"/"string", value = "action_content" }
-- For keys: value can be string or table with modifiers
-- For strings: value is the text to type
local temp_keybindings_mapping = {
	{
		key = "h",
		actions = {
			{ type = "key", value = "tab" },
		},
	},
	--) Examples:
	-- { key = "a", actions = { { type = "string", value = "Hello World!" } } },
	-- { key = "j", actions = { { type = "key", value = "down" } } },
	-- { key = "k", actions = { { type = "key", value = "up" } } },
}

-- Initialize the spoon
function obj:init()
	-- Create modal for temp keybindings
	self.modal = hs.hotkey.modal.new()

	-- Setup activation hotkey
	hs.hotkey.bind({ "alt" }, ",", function()
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
		local actions = mapping.actions

		self.modal:bind({}, key, function()
			self:executeActionChain(actions)
		end)
	end
end

-- Execute a chain of actions with small delays between them
function obj:executeActionChain(actions)
	for i, action in ipairs(actions) do
		-- Add small delay between actions for better reliability
		local delay = (i - 1) * 0.05 -- 50ms delay between actions

		hs.timer.doAfter(delay, function()
			if action.type == "key" then
				self:handleKeySubstitution(action.value)
			elseif action.type == "string" then
				self:handleStringSubstitution(action.value)
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

-- Generate description for action chain (for alert message)
function obj:getActionChainDescription(actions)
	local descriptions = {}
	for _, action in ipairs(actions) do
		if action.type == "key" then
			if type(action.value) == "string" then
				table.insert(descriptions, action.value)
			else
				table.insert(descriptions, table.concat(action.value, "+"))
			end
		else
			-- Truncate long strings for display
			local text = action.value
			if #text > 15 then
				text = string.sub(text, 1, 12) .. "..."
			end
			table.insert(descriptions, "'" .. text .. "'")
		end
	end
	return table.concat(descriptions, "→")
end

-- Toggle temp mode on/off
function obj:toggleTempMode()
	if self.isActive then -- deactivate mode
		self.isActive = false
		self.modal:exit()
		hs.alert.show("💧", 1)
		print("Temp keybindings mode deactivated")
	else -- activate mode
		self.isActive = true
		self.modal:enter()

		hs.alert.show("🔥", 2)
		print("Temp keybindings mode activated")
	end
end

return obj
