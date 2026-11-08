local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua")---@type utils

local eid = GetUpdatedEntityID()
local proj = EntityGetFirstComponentIncludingDisabled(eid, "ProjectileComponent")
if not proj then return end

local last_frame = ComponentGetValue2(proj, "mLastFrameDamaged")
if not last_frame or last_frame < 1 then return end

ComponentSetValue2(proj, "mLastFrameDamaged", 0)

local count = utils.GetInternalInt(eid, "hardmod_piercing_count") or 1

if count == -1 then
	EntityRemoveComponent(eid, GetUpdatedComponentID())
	return
end

if count == 1 then
	ComponentSetValue2(proj, "lifetime", 1)
else
	utils.SetInternalInt(eid, "hardmod_piercing_count", count - 1)
end
