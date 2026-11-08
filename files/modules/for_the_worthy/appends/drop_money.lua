---@diagnostic disable: undefined-global
if not hooks then return end

table.insert(hooks, {
	id = "hell_mode_multiplier",
	func = function(data)
		if GameHasFlagRun("hardmod_hell") then
			data.multiplier = data.multiplier * 0.25
		end
	end
})
