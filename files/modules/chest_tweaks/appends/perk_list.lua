---@diagnostic disable: undefined-global

table.insert(perk_list, {
  id = "HARDMOD_BETTER_CHESTS",
  ui_name = "$hardmod_perk_better_chests_name",
  ui_description = "$hardmod_perk_better_chests_desc",
  ui_icon = "mods/noita.hardmod/files/modules/chest_tweaks/gfx/perks/better_chests_016.png",
  perk_icon = "mods/noita.hardmod/files/modules/chest_tweaks/gfx/perks/better_chests.png",
  stackable = true,
  one_off_effect = false,
  usable_by_enemies = false,
  stackable_maximum = 128,
  func = function() end,
  func_remove = function() end,
})

table.insert(perk_list, {
  id = "HARDMOD_TREASURE_HUNTER",
  ui_name = "$hardmod_perk_treasure_hunter_name",
  ui_description = "$hardmod_perk_treasure_hunter_desc",
  ui_icon = "mods/noita.hardmod/files/modules/chest_tweaks/gfx/perks/treasure_hunter_016.png",
  perk_icon = "mods/noita.hardmod/files/modules/chest_tweaks/gfx/perks/treasure_hunter.png",
  stackable = true,
  one_off_effect = false,
  usable_by_enemies = false,
  stackable_maximum = 3,
  func = function() end,
  func_remove = function() end,
})
