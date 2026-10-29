---@class (exact) enemy_perk
---@field id string string ID
---@field name string? string name (viewable in progress)
---@field description string description of the perk (viewable in progress)
---@field icon string? path to the perk's icon
---@field weight number? probability of the perk being pulled, default 10
---@field max int? max number of this perk an enemy can have
---@field condition function? if added, this function must return true, is passed the `data` table
---@field func function function that actually does the stuff, is passed the `data` table

local sprites_path = "mods/noita.hardmod/files/modules/enemy_perks/perk_sprites/"

-- The `data` table provides `target_enemy` (eid), `already_held_perks` (perk_id[]), `player` (eid) and `player_poly_identity` (table)

---@type enemy_perk[]
local perks = {
	--[[
	{
		id = "TEST_PERK",
		name = "$hardmod_enemy_perks_test",
		description = "Wow, what a great test perk!",
		weight = 10,
		condition = function(self, data) end,
		func = function(self, holder, perk_entity)
			GetGameEffectLoadTo(holder, "REGENERATION", true)
		end
	},--]]
	{
		id = "LAVA_BLOOD",
		name = "$hardmod_eperk_lava_blood_name",
		description = "$hardmod_eperk_lava_blood_desc",
		icon = sprites_path.."lava_blood.png",
		weight = 5,
		max = 1,
		condition = function(self, data)
			if not data.blood_perk then return true end
		end,
		func = function(self, entity_id, data)
			local dmc = EntityGetFirstComponent(entity_id, "DamageModelComponent")
			if not dmc then return end

			ComponentSetValue2(dmc, "blood_material", "lava")
			ComponentSetValue2(dmc, "blood_spray_material", "lava")
			ComponentSetValue2(dmc, "wet_status_effect_damage", 0.2)
			EntitySetDamageFromMaterial(entity_id, "water", 0.0005)
			EntitySetDamageFromMaterial(entity_id, "mud", 0.0005)
			EntitySetDamageFromMaterial(entity_id, "water_swamp", 0.0005)
			EntitySetDamageFromMaterial(entity_id, "water_salt", 0.0005)
			EntitySetDamageFromMaterial(entity_id, "swamp", 0.0005)
			EntitySetDamageFromMaterial(entity_id, "snow", 0.0005)
			EntitySetDamageFromMaterial(entity_id, "water_ice", 0.0005)

			data.blood_perk = "lava" --do this for condition func so multiple blood perks aren't rolled
		end
	},
	{
		id = "HARDMOD_KAMIKAZE",
		name = "$hardmod_eperk_kamikaze_name",
		description = "$hardmod_eperk_kamikaze_desc",
		icon = sprites_path.."kamikaze.png",
		weight = 2,
		max = 1,
		condition = function(self, data)
			local entity_id = data.target_enemy
			local animal_ai_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent") or 0
            if animal_ai_comp > 0 and not ComponentGetValue2(animal_ai_comp,"attack_ranged_enabled") then
				-- condition = function(self, data)
				-- -- @UserK how does this workkk
				-- 	if data.how_many_of_each_perk["HARDMOD_KAMIKAZE"] == 0 then return true end
				-- end,
				return true
            end
		end,
		func = function(self, entity_id, data)
			-- show nuke particles on the enemy
			local x, y = EntityGetTransform(entity_id)
			EntityAddChild(entity_id, EntityLoad( "mods/noita.hardmod/files/modules/enemy_perks/entities/kamikaze_particles.xml", x, y))

			-- make the enemy explode on death
			EntityAddComponent2(entity_id, "LuaComponent", {
				script_death = "mods/noita.hardmod/files/modules/enemy_perks/scripts/kamikaze_on_death.lua",
				execute_every_n_frame = -1,
			})

			-- make the enemy explode when near the player
			EntityAddComponent2(entity_id, "LuaComponent", {
				script_source_file = "mods/noita.hardmod/files/modules/enemy_perks/scripts/kamikaze_update.lua",
				execute_every_n_frame = 1,
			})
		end
	},
	{
		id = "HARDMOD_PROTECTOR",
		name = "$hardmod_eperk_protector_name",
		description = "$hardmod_eperk_protector_desc",
		icon = sprites_path.."protector.png",
		weight = 1,
		max = 1,
		condition = function(self, data)
			local dmg_comp = EntityGetFirstComponentIncludingDisabled( data.target_enemy, "DamageModelComponent" )
			if dmg_comp ~= nil then
				local max_hp = ComponentGetValue2( dmg_comp, "max_hp" )
				if max_hp >= 2 then
					return true
				end
			end
		end,
		func = function(self, entity_id, data)
			local x, y = EntityGetTransform(entity_id)
			EntityAddChild(entity_id, EntityLoad( "mods/noita.hardmod/files/modules/enemy_perks/entities/protector_shield.xml", x, y))
		end
	},
	{
		id = "HARDMOD_IMPERVIOUS",
		name = "$hardmod_eperk_impervious_name",
		description = "$hardmod_eperk_impervious_desc",
		icon = sprites_path.."impervious.png",
		weight = 1,
		max = 1,
		func = function(self, entity_id, data)
			local x, y = EntityGetTransform(entity_id)
			EntityAddChild(entity_id, EntityLoad("mods/noita.hardmod/files/modules/enemy_perks/entities/impervious_shield.xml", x, y))

			local dmg_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
			if dmg_comp ~= nil then
				ComponentObjectSetValue2(dmg_comp, "damage_multipliers", "projectile", 0.0)
				ComponentObjectSetValue2(dmg_comp, "damage_multipliers", "melee", 1000.0)
			end			
		end
	},
	{
		id = "HARDMOD_DRY_SPELL",
		name = "$hardmod_eperk_dry_spell_name",
		description = "$hardmod_eperk_dry_spell_desc",
		icon = sprites_path.."dry_spell.png",
		weight = 2,
		max = 1,
		func = function(self, entity_id, data)
			local x, y = EntityGetTransform(entity_id)
			EntityAddChild(entity_id, EntityLoad("mods/noita.hardmod/files/modules/enemy_perks/entities/dry_spell.xml", x, y))
		end
	},
	{
		id = "HARDMOD_THUNDERLORD",
		name = "$hardmod_eperk_thunderlord_name",
		description = "$hardmod_eperk_thunderlord_desc",
		icon = sprites_path.."thunderlord.png",
		weight = 5,
		max = 1,
		condition = function(self, data)
			local entity_id = data.target_enemy
			local animal_ai_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent") or 0
            if animal_ai_comp > 0 and ComponentGetValue2(animal_ai_comp,"attack_ranged_enabled") then
            	return true
            end
		end,
		func = function(self, entity_id, data)
			GetGameEffectLoadTo(entity_id, "PROTECTION_ELECTRICITY", true)
			EntityAddComponent2(entity_id, "LuaComponent", {
	            script_shot = "mods/noita.hardmod/files/modules/enemy_perks/scripts/thunderlord_on_shot.lua",
				execute_every_n_frame = -1,
            })
		end
	},
	{
		id = "HARDMOD_PYRELORD",
		name = "$hardmod_eperk_pyrelord_name",
		description = "$hardmod_eperk_pyrelord_desc",
		icon = sprites_path.."pyrelord.png",
		weight = 5,
		max = 1,
		condition = function(self, data)
			local entity_id = data.target_enemy
			local animal_ai_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent") or 0
            if animal_ai_comp > 0 and ComponentGetValue2(animal_ai_comp,"attack_ranged_enabled") then
            	return true
            end
		end,
		func = function(self, entity_id, data)
			GetGameEffectLoadTo(entity_id, "PROTECTION_FIRE", true)
			EntityAddComponent2(entity_id, "LuaComponent", {
	            script_shot = "mods/noita.hardmod/files/modules/enemy_perks/scripts/pyrelord_on_shot.lua",
				execute_every_n_frame = -1,
            })
		end
	},
	{
		id = "HARDMOD_VIGOUR",
		name = "$hardmod_eperk_vigour_name",
		description = "$hardmod_eperk_vigour_desc",
		icon = sprites_path.."vigour.png",
		weight = 1,
		max = 1,
		-- condition = function(self, data)
		-- -- @UserK how does this workkk
		-- 	if data.how_many_of_each_perk["HARDMOD_KAMIKAZE"] == 0 then return true end
		-- end,
		func = function(self, entity_id, data)
			-- make the enemy explode on death
			EntityAddComponent2(entity_id, "LuaComponent", {
				script_death = "mods/noita.hardmod/files/modules/enemy_perks/scripts/vigour_on_death.lua",
				execute_every_n_frame = -1,
			})
		end
	},
}

for _,perk in ipairs(perks) do
	perk.name = perk.name or perk.id
	perk.weight = perk.weight or 10
	perk.icon = ModDoesFileExist(perk.icon or "") and perk.icon or "mods/noita.hardmod/files/modules/enemy_perks/perk_sprites/missing.png"
	if perk.max then --This is sane enough.
		local cond = perk.condition or function(...) return true end
		perk.condition = function(self, data)
			return cond(self, data) and (data.how_many_of_each_perk[self.id] or 0) < self.max
		end
	end
end

return perks