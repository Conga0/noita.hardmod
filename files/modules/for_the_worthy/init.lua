local hooks = {}
local root = "mods/noita.hardmod/files/modules/for_the_worthy/"

dofile_once(root.."shared.lua")
ModLuaFileAppend("data/scripts/perks/perk.lua", root.."appends/perk.lua")

ModLuaFileAppend("data/scripts/_items/drop_money.lua", root.."appends/drop_money.lua")

function hooks.new_eid(eid)
	if not GameHasFlagRun("hardmod_hell") then return end
	if not EntityHasTag(eid, "enemy") then return end

	HardmodTransformEnemyHell(eid)
end

return hooks
