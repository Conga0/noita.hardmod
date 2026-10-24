local lootlib = dofile_once("mods/noita.hardmod/lib/lootlib.lua")---@class lootlib

-- ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/noita.hardmod/files/modules/chest_tweaks/appends/perk_list.lua")
ModLuaFileAppend("data/scripts/items/chest_random.lua", "mods/noita.hardmod/files/modules/chest_tweaks/appends/chest_random.lua")
ModLuaFileAppend("data/scripts/items/chest_random_super.lua", "mods/noita.hardmod/files/modules/chest_tweaks/appends/chest_random_super.lua")

lootlib.add_patch_script("mods/noita.hardmod/files/modules/chest_tweaks/loot/chest.lua")
lootlib.add_patch_script("mods/noita.hardmod/files/modules/chest_tweaks/loot/great_chest.lua")

return {}
