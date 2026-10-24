local lootlib = dofile_once("mods/noita.hardmod/lib/lootlib.lua")---@class lootlib

local chest = lootlib.get_loot_table("chest_random_super")

local rain = lootlib.get_label(chest, "rain_gold") or {}
rain.success.entity = nil
rain.success.pick_weighted = {
  { weight = 15, entity = "data/entities/projectiles/rain_gold.xml" },
  { weight = 10, entity = "data/entities/misc/chest_rain.xml" },
  { weight = 5, entity = "data/entities/misc/utility_rain.xml" },
  { weight = 1, entity = "data/entities/misc/worm_rain.xml" },
}

lootlib.extend_loot_table("chest_random_super", {
  {
    label = "circle_of_vigour",
    weight = 4,
    entity = "data/entities/projectiles/deck/regeneration_field.xml"
  }
  -- {
  --   weight = 10,
  --   entity = "data/entities/projectiles/deck/nuke.xml"
  -- },
  -- {
  --   weight = 10,
  --   entity = "data/entities/animals/boss_wizard/statusburst.xml"
  -- },
})
