---@diagnostic disable-next-line: undefined-global
table.insert(perk_list, {
  id = "HARDMOD_PERK_BETTER_CHESTS",
  ui_name = "$hardmod_perk_better_chests_name",
  ui_description = "$hardmod_perk_better_chests_desc",
  ui_icon = "mods/noita.hardmod/files/modules/chest_tweaks/gfx/perks/better_chests_016.png",
  perk_icon = "mods/noita.hardmod/files/modules/chest_tweaks/gfx/perks/better_chests.png",
  stackable = true,
  one_off_effect = false,
  usable_by_enemies = false,
  func = function()
    local stacks = tonumber(GlobalsGetValue("hardmod_better_chests_stacks")) or 0;

    GlobalsSetValue("hardmod_better_chests_stacks", tostring(stacks + 1))
  end,
  func_remove = function()
    GlobalsSetValue("hardmod_better_chests_stacks", "0")
  end,
})
