local lootlib = dofile_once("mods/noita.hardmod/lib/lootlib.lua")---@type lootlib
local chest = lootlib.get_loot_table("chest_random")

local bomb = lootlib.get_label(chest, "bomb")
if bomb then
  bomb.entity = nil
  bomb.pick_weighted = {
    { weight = 10, entity = "data/entities/projectiles/bomb_small.xml" },
    { weight = 10, entity = "data/entities/projectiles/deck/tentacle_portal.xml" },
    { weight = 10, entity = "data/entities/projectiles/deck/tentacle_portal.xml" },
  }

  bomb.var = "rolls"
  bomb.add = { a = 0, b = 2 }
end

local heart = lootlib.get_label(chest, "hearts")
if heart then
  table.insert(heart.pick_weighted, {
    weight = 20,
    entity = "mods/noita.hardmod/files/modules/chest_tweaks/entities/heart_healing.xml",
  })
end

lootlib.extend_loot_table("misc_items", {
  { weight = 1, entity = "data/entities/items/pickup/broken_wand.xml" },
  { weight = 1, entity = "data/entities/items/pickup/beamstone.xml" },
})

lootlib.extend_loot_table(chest, {
  {
    -- funny
    label = "bones",
    weight = 7,
    pick_chance_at_least_one = true,
    pick_chance_all = {
      { chance = 20, entity = "data/entities/props/physics_bone_01.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_02.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_03.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_04.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_05.xml" },
      { chance = 20, entity = "data/entities/props/physics_bone_06.xml" },
    },
    var = "rolls", add = 1
  },
  {
    label = "eggs",
    weight = 5,
    pick_chance_at_least_one = true,
    pick_chance_all = {
      { chance = 20, entity = "data/entities/items/pickup/egg_monster.xml" },
      { chance = 20, entity = "data/entities/items/pickup/egg_slime.xml" },
      { chance = 20, entity = "data/entities/items/pickup/egg_red.xml" },
      { chance = 20, entity = "data/entities/items/pickup/egg_fire.xml" },
      { chance = 10, entity = "data/entities/items/pickup/egg_purple.xml" },
      { chance = 5, entity = "data/entities/items/pickup/egg_worms.xml" },
    }
  }
})
