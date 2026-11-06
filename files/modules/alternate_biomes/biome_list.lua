local root = "mods/noita.hardmod/files/modules/alternate_biomes/"

-- `name` and `script` are important for other modules extending vanilla biomes
-- or relying on UI name to identify them

local alt_biomes = {
	{
		name = "$hardmod_biomename_infested_mines",
		biome = "fungal_mines",
		colour_id = 0xff583e35,
		script = root.."biomes/fungal_mines.lua",
		weight = 100
	},
	{
		name = "$hardmod_biomename_sand_pits",
		biome = "sand_pits",
		colour_id = 0xff78712b,
		script = root.."biomes/sand_pits.lua",
		weight = 100
	}
}

local replacement_data = {
	mines = {
		colour_id = 0xffd57917,
		replace_with = 0xff583e35,
		probability = .5
	},
	coal_pits = {
		colour_id = 0xff124445,
		replace_with = 0xff78712b,
		probability = .5
	},
}

return {alt_biomes,replacement_data}