dofile_once("mods/noita.hardmod/files/modules/stronger_enemies/patcher.lua")

PatchEnemies(g_big_enemies, {
  ["data/entities/animals/drone_shield.xml"] = { ng = 3 },
})

AddEnemies(g_small_enemies, {
	{
		prob = 0.08,
		entity = "mods/noita.hardmod/files/modules/stronger_enemies/entities/hardmod_wizard_confusion.xml"
	},
})

AddEnemies(g_big_enemies, {
	{
		prob = 0.3,
		entity = "data/entities/animals/fungus_giga.xml"
	},
	{
		prob = 0.1,
		entity = "data/entities/animals/barfer.xml"
	},
	{
		prob = 0.06,
		entity = "data/entities/animals/weakspirit.xml",
	},
	{
		ngpluslevel = 2, prob = 0.07,
		entity 	= "data/entities/buildings/snowcrystal.xml"
	},
})
