return function(x, y)
	for _,entity_id in ipairs(EntityGetInRadius(x, y, 130)) do
		if EntityGetName(entity_id) == "hardmod_collapse_check_perk_missing" then
			local comp = EntityGetFirstComponent(entity_id, "LuaComponent")
			if comp then ComponentSetValue2(comp, "mNextExecutionTime", GameGetFrameNum() + 1) end
			return
		end
	end
end