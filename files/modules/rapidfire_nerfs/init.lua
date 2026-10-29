local hooks = {}

ModLuaFileAppend(
	"data/scripts/gun/gun_actions.lua",
	"mods/noita.hardmod/files/modules/rapidfire_nerfs/scripts/actions_append.lua"
)

ModLuaFileAppend(
	"data/scripts/gun/gun.lua",
	"mods/noita.hardmod/files/modules/rapidfire_nerfs/scripts/null_mana.lua"
)

return hooks
