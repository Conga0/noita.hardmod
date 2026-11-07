local dir = "mods/noita.hardmod/files/modules/alternate_biomes/"

-- `name` and `script` are important for other modules extending vanilla biomes
-- or relying on UI name to identify them

local alt_biomes = {
	{
		name = "$hardmod_biomename_infested_mines",
		biome = "fungal_mines",
		colour_id = 0xff583e35,
		replaces = "mines",
		replaces_colour = 0xffd57917,
		script = dir.."biomes/fungal_mines.lua",
		probability = .5
	},
	{
		name = "$hardmod_biomename_sand_pits",
		biome = "sand_pits",
		colour_id = 0xff78712b,
		replaces = "excavationsite",
		replaces_colour = 0xff124445,
		script = dir.."biomes/sand_pits.lua",
		probability = .5
	}
}

return alt_biomes
