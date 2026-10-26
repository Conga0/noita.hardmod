dofile_once("mods/noita.hardmod/files/modules/stronger_enemies/patch.lua")

PatchEnemies(g_big_enemies, {
  ["data/entities/animals/scavenger_clusterbomb.xml"] = { ng = 2 },
})

AddEnemies(g_big_enemies, {
  {
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/scavenger_mine.xml",
		ngpluslevel = 1,
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/animals/barfer.xml"
	},
})
