dofile_once("mods/noita.hardmod/files/modules/stronger_enemies/patch.lua")

AddEnemies(g_big_enemies, {
  {
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/animals/fungus_giga.xml"
	},
	{
		prob   		= 0.08,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/animals/barfer.xml"
	},
})
