local lootlib = dofile_once("mods/noita.hardmod/lib/lootlib.lua")---@type lootlib

lootlib.init_patches("mods/noita.hardmod/lib/lootlib.lua")
lootlib.add_patch_script("mods/noita.hardmod/files/modules/chest_tweaks/loot/extra_rolls.lua")
lootlib.add_patch_script("mods/noita.hardmod/files/modules/chest_tweaks/loot/chest.lua")
lootlib.add_patch_script("mods/noita.hardmod/files/modules/chest_tweaks/loot/great_chest.lua")

ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/noita.hardmod/files/modules/chest_tweaks/perk_list_appends.lua")

return {}
