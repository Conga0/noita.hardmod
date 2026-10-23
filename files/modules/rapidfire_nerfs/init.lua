local hooks = {}

hooks.mod_post_init = function()
	ModLuaFileAppend(
		"data/scripts/gun/gun_actions.lua",
		"mods/noita.hardmod/files/modules/rapidfire_nerfs/actions_append.lua" )
end

return hooks --Don't forget to do this if you want your changes to apply!!!!