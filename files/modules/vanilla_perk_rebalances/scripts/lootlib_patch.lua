local lootlib = dofile_once("mods/noita.hardmod/lib/lootlib.lua") ---@type lootlib

lootlib.extend_loot_table("misc_items", {
  { weight = 1, entity = "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/entities/items/cheese.xml" },
})
