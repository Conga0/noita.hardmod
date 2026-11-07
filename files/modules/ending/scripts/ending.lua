local integral_modules = {
	-- 100% needed
	"enemy_perks",
	"limited_spells",
	"holy_mountain_rework",
	"vanilla_quests",
	"vanilla_bosses",
	"vanilla_perk_rebalances",
	"vanilla_spell_rebalances",
	"spells_reweighted",
	"phantom_nemesis",
	"rapidfire_nerfs",
	"stronger_enemies",
	"ending",
	"biome_map",
	
	-- cheeses or other stuff, not fully sure
	"no_more_max_hp_cheesing",
	"nerf_vanilla_cheeses",
	"nerfed_combat_healing",
	"cheeseless_triggers",
	"biome_modifiers",
	"potions", -- removes ambro
	"credits", -- disabled in credits

	-- very not sure, ig not:
	-- "trappier_traps",
	-- "alternate_biomes",
}

local give_reward = true

for _,module in pairs(integral_modules) do
	if ModSettingGet("noita.hardmod."..module..".disabled") then
		give_reward = false
	end
end

if give_reward then
	AddFlagPersistent("hardmod_game_completed")
else
	AddFlagPersistent("hardmod_game_fool_completed")
end
