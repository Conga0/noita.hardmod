dofile_once("mods/noita.hardmod/files/modules/stronger_enemies/patcher.lua")

PatchEnemies(g_big_enemies, {
  ["data/entities/animals/tank_super.xml"] = { ng = 2 },
})

AddEnemies(g_small_enemies, {
  {
    prob        = 0.1,
    min_count   = 1,
    max_count   = 1,
    entity      = "data/entities/animals/wizard_dark.xml",
    ngpluslevel = 1,
  },
  {
    prob        = 0.1,
    min_count   = 1,
    max_count   = 1,
    entity      = "data/entities/animals/wizard_twitchy.xml",
    ngpluslevel = 1,
  },
})
