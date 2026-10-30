ModLuaFileAppend("data/scripts/biome_modifiers.lua", "mods/noita.hardmod/files/modules/biome_modifiers/modifiers/patch.lua")

return {
  mod_post_init = function()
    ModLuaFileAppend("data/scripts/biome_modifiers.lua", "mods/noita.hardmod/files/modules/biome_modifiers/modifiers/list.lua")
  end
}
