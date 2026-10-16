local module = {}

module.mod_post_init = function()
	-- lmao have fun with 8 orb kolmi idiot
	-- originally i made kolmi acid immune but it seems 8 orb kolmi is already acid immune
	ModLuaFileAppend("data/entities/animals/boss_centipede/boss_centipede_update.lua", "mods/noita.hardmod/files/modules/stronger_kolmi/boss_centipede_update_append.lua")
end

return module