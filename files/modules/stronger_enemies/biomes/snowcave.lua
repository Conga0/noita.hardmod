dofile_once("mods/noita.hardmod/files/modules/stronger_enemies/patch.lua")

PatchEnemies(g_big_enemies, {
  ["data/entities/animals/thundermage_big.xml"] = { ng = 2 },
})
