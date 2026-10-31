local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua")---@type utils

local function patch_starting_wand()
	local proc = "data/scripts/gun/procedural/"
	
	local starting_wand = proc.."starting_wand.lua"
	local starting_bomb_wand = proc.."starting_bomb_wand.lua"
	
	utils.patchifile(starting_wand, {
		{
			from = "local mana_max",
			insert_before = [[
				gun.deck_capacity = {3,4}
				gun.actions = { "LIGHT_BULLET", "SPITTER", "BOUNCY_ORB" }
			]]
		},
		{
			from = "math.min(Random(1,3)",
			to = "math.min(Random(2,3)"
		},
		-- makes all possible projs have an even chance to generate
		{ from = "( Random(1,100) < 50 )", to = "( true)" }
	})

	utils.patchifile(starting_bomb_wand, {
		{
			from = "local mana_max",
			insert_before = [[
				gun.shuffle_deck_when_empty = 0
				gun.deck_capacity = 2
			]]
		},
		{ from = "( Random(1,100) < 50 )", to = "( true)" }
	})
	
	ModTextFileSetContent(proc.."starting_wand_daily.lua", 'dofile("'..starting_wand..'")')
	ModTextFileSetContent(proc.."starting_bomb_wand_daily.lua", 'dofile("'..starting_bomb_wand..'")')
end

patch_starting_wand()

ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/noita.hardmod/files/modules/unshuffle/appends/perk_list.lua")

return {
	world_init = function()
		GlobalsSetValue("PERK_NO_MORE_SHUFFLE_WANDS", "1")
	end
}
