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
			return not data.blood_perk
		end,
		func = function(self, entity_id, data)
			local dmc = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
			if not dmc then return end

			ComponentSetValue2(dmc, "blood_material", "lava")
			ComponentSetValue2(dmc, "blood_spray_material", "lava")
			ComponentSetValue2(dmc, "wet_status_effect_damage", 0.1)
			EntitySetDamageFromMaterial(entity_id, "water", 0.0002)
			EntitySetDamageFromMaterial(entity_id, "mud", 0.0002)
			EntitySetDamageFromMaterial(entity_id, "water_swamp", 0.0002)
			EntitySetDamageFromMaterial(entity_id, "water_salt", 0.0002)
			EntitySetDamageFromMaterial(entity_id, "swamp", 0.0002)
			EntitySetDamageFromMaterial(entity_id, "snow", 0.0002)
			EntitySetDamageFromMaterial(entity_id, "water_ice", 0.0002)

			EntitySetDamageFromMaterial(entity_id, "lava", 0)
			GetGameEffectLoadTo(entity_id, "PROTECTION_FIRE", false)

			data.blood_perk = "lava" --do this for condition func so multiple blood perks aren't rolled
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