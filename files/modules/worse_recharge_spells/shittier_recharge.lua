-- Chainsaw wrappers in shambles
local wrappers = {
	CHAINSAW = true,
	LUMINOUS_DRILL = true,
}

-- worst code?
local old_play_action = play_action
local last_c = nil
play_action = function(action, ...)
	if(wrappers[action.id])then
		if(last_c == nil)then
			last_c = c
		end
	else
		if(last_c)then
			c = last_c
		end
		last_c = nil
	end
	old_play_action(action, ...)
end