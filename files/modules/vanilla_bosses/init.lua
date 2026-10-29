local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

ModLuaFileAppend(
  "data/entities/animals/boss_pit/boss_pit_damage.lua",
  "mods/noita.hardmod/files/modules/vanilla_bosses/appends/boss_pit_damage.lua"
)

return {}
