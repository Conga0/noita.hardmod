local hooks = {}

hooks.mod_init = function()
	ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/noita.hardmod/files/modules/cheeseless_triggers/scripts/gun_payload_cast_delay.lua")
	ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/noita.hardmod/files/modules/cheeseless_triggers/scripts/add_card_cost.lua")
end

return hooks
