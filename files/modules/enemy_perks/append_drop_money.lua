return function(hooks)
	hooks.pre_funcs[#hooks.pre_funcs+1] = function(data) ---@param data gold_drop_data
		if GameHasFlagRun("hardmod_blessed_blood_money") and EntityHasTag(data.entity, "hardmod_blessed") then
			for _,child in ipairs(EntityGetAllChildren(data.entity) or {}) do
				if EntityGetName(child) == "hardmod.enemy_perks" then
					for _,varcomp in ipairs(EntityGetComponent(child, "VariableStorageComponent") or {}) do
						if ComponentGetValue2(varcomp, "name") == "enemy_perk_data" then
							data.blood_money_chance = data.blood_money_chance + math.min(100, ComponentGetValue2(varcomp, "value_int") * 10)
							break
						end
					end
					break
				end
			end
		end
	end
end