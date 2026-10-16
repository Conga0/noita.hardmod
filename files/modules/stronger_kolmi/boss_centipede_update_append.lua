local starting_orbs = 8
local original_init_boss = init_boss

init_boss = function()
	local entity = GetUpdatedEntityID()
	local original_count = GameGetOrbCountThisRun
	GameGetOrbCountThisRun = function()
		return original_count() + starting_orbs
	end
	original_init_boss()
	GameGetOrbCountThisRun = original_count

	EntityAddTag( entity, "touchmagic_immunity") -- don't fucking touch my boy
end
