local lootlib = dofile_once("mods/noita.hardmod/lib/lootlib.lua")---@class lootlib

local chest = lootlib.get_loot_table("chest_random")

local bomb = lootlib.get_label(chest, "bomb")
bomb.weight = 7
bomb.var = "rolls"
bomb.add = { a = 0, b = 2 }

local misc = lootlib.get_label(chest, "misc_items") or {}
table.insert(misc.pick_random, { entity = "data/entities/items/pickup/broken_wand.xml" })

lootlib.extend_loot_table("chest_random", {
  {
    weight = 7,
    is_bad = true,
    entity = "data/entities/projectiles/deck/tentacle_portal.xml"
  },
  {
    -- funny
    weight = 7,
    pick_chance_all = {
      { chance = 100, entity = "data/entities/props/physics_bone_01.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_02.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_03.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_04.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_05.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_06.xml" },
    },
    var = "rolls", add = 1
  }
})
