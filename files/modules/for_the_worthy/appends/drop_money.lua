---@param hooks drop_money_hooks
return function(hooks)
	table.insert(hooks.pre_funcs, {
		id = "hell_mode_multiplier",
		func = function(data)
			if GameHasFlagRun("hardmod_hell") then
				data.multiplier = data.multiplier * 0.25
			end
		end
	})
end
