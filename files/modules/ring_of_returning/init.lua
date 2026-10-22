local hooks = {}
local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

hooks.mod_post_init = function()
	ModLuaFileAppend( "data/scripts/buildings/workshop_trigger_check_stats.lua", "mods/noita.hardmod/files/modules/ring_of_returning/scripts/workshop_trigger_check_stats_append.lua" )
end

return hooks --Don't forget to do this if you want your changes to apply!!!!