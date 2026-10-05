local hooks = {}

hooks.mod_post_init = function()
	ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/perks_append.lua")
end

return hooks --Don't forget to do this if you want your changes to apply!!!!