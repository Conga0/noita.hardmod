local biome_index ---@type biome_path_to_simple_id

local hell_damage_multipliers = {
	melee = 3,
	projectile = 2,
	explosion = 2,
	electricity = 2,
	fire = 2,
	drill = 2,
	slice = 2,
	ice = 2,
	healing = 0.75,
	radioactive = 2,
	poison = 3,
	curse = 3,
	holy = 2,
}

local hell_enemy_biome_multipliers = {
	["mines"] = { hp = 2, speed = 0.6 },
	["collapsed_mines"] = { hp = 2, speed = 0.6 },
	["coal_pits"] = { hp = 2, speed = 0.5 },
	["fungal_caverns"] = { hp = 3, speed = 0.4 },
	["snowy_depths"] = { hp = 2.5, speed = 0.5 },
	["hiisi_base"] = { hp = 3.5, speed = 0.6 },
	["jungle"] = { hp = 7, speed = 0.4 },
	["ancient_lab"] = { hp = 7, speed = 0.4 },
	["lukki_lair"] = { hp = 7, speed = 0.4 },
	["vault"] = { hp = 8, speed = 0.4 },
	["magical_temple"] = { hp = 8, speed = 0.4 },
	["temple_of_the_art"] = { hp = 8, speed = 0.3 },
	["wizards_den"] = { hp = 8, speed = 0.5 },

	["surface_forest"] = { hp = 15, speed = 0.5 },
	["surface_desert"] = { hp = 15, speed = 0.5 },
	["pyramid"] = { hp = 7, speed = 0.4 },
	["sandcave"] = { hp = 10, speed = 0.4 },
	["wandmart"] = { hp = 10, speed = 0.5 },
	["hell"] = { hp = 20, speed = 0.1 },
	["tower"] = { hp = 20, speed = 0.1 },
	["sky"] = { hp = 20, speed = 0.1 },
	["cloudscape"] = { hp = 16, speed = 0.25 },
	["meat_realm"] = { hp = 16, speed = 0.25 },
	["frozen_vault"] = { hp = 16, speed = 0.25 },
	["powerplant"] = { hp = 16, speed = 0.25 },
}

local hell_conversions = {
	{ from = "rock_hard_border", to = "rock_static_cursed" },
	{ from = "magic_liquid_protection_all", to = "material_darkness" },
	{ from = "magic_liquid_hp_regeneration", to = "material_darkness" },
	{ from = "magic_liquid_hp_regeneration_unstable", to = "material_darkness" },
	{ from = "magic_liquid_unstable_polymorph", to = "magic_liquid_random_polymorph" },
	{ from = "porridge", to = "milk" },
}

---@param player entity_id
function HardmodEnableHell(player)
	GameAddFlagRun("hardmod_hell")

	-- no eggsploit (or at least much harder)
	for _,proj in pairs(EntityGetWithTag("projectile")) do
		EntityKill(proj)
	end

	local dmg = EntityGetFirstComponent(player, "DamageModelComponent")
	if dmg then
		ComponentSetValue2(dmg, "max_hp", 8)
		ComponentSetValue2(dmg, "hp", 8)

		ComponentSetValue2(dmg, "air_in_lungs", 7)
		ComponentSetValue2(dmg, "air_in_lungs_max", 7)

		for key,mult in pairs(hell_damage_multipliers) do
			local value = ComponentObjectGetValue2(dmg, "damage_multipliers", key)
			local multiplied = value * mult

			ComponentObjectSetValue2(dmg, "damage_multipliers", key, multiplied)
		end
	end

	for _,conv in pairs(hell_conversions) do
		ConvertMaterialEverywhere(CellFactory_GetType(conv.from), CellFactory_GetType(conv.to))
	end

	for _,enemy in pairs(EntityGetWithTag("enemy")) do
		HardmodTransformEnemyHell(enemy)
	end
end

function HardmodTransformEnemyHell(eid)
	if EntityHasTag(eid, "hardmod_hell_mult") then return end
	if EntityHasTag(eid, "boss") then return end

	if not biome_index then
		biome_index = dofile_once("mods/noita.hardmod/lib/biome_index.lua")
	end

	local x, y = EntityGetTransform(eid)
	local biome = biome_index[DebugBiomeMapGetFilename(x, y)]
	if not biome then return end

	local multipliers = hell_enemy_biome_multipliers[biome]
	if not multipliers then return end

	local dmc = EntityGetFirstComponent(eid, "DamageModelComponent")
	if dmc then
		local max_hp = ComponentGetValue2(dmc, "max_hp")
		local new_hp = max_hp * multipliers.hp

		ComponentSetValue2(dmc, "max_hp", new_hp)
		ComponentSetValue2(dmc, "hp", new_hp)
	end

	local aicomp = EntityGetFirstComponent(eid, "AnimalAIComponent")
	if aicomp then
		local melee = ComponentGetValue2(aicomp, "attack_melee_frames_between")
		local ranged = ComponentGetValue2(aicomp, "attack_ranged_frames_between")

		ComponentSetValue2(aicomp, "attack_melee_frames_between", (melee or 0) * multipliers.speed)
		ComponentSetValue2(aicomp, "attack_ranged_frames_between", (ranged or 0) * multipliers.speed)
	end

	EntityAddTag(eid, "hardmod_hell_mult")
end
