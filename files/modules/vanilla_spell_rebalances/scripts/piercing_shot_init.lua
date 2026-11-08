local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua")---@type utils
local eid = GetUpdatedEntityID()

local count = utils.GetInternalInt(eid, "hardmod_piercing_count") or 0
count = count + 5

if count >= 50 then
	count = -1
end

utils.SetInternalInt(eid, "hardmod_piercing_count", count)
