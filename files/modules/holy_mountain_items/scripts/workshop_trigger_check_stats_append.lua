local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua") ---@type utils

local _collision_trigger = collision_trigger
function collision_trigger(...)
	_collision_trigger(...)

	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity_id)
	local reference_id = EntityGetClosestWithTag(x, y, "workshop_reference")

	if reference_id and reference_id ~= 0 then
		x, y = EntityGetTransform(reference_id)
	else
		print("no reference found for ring of returning")
	end

	print("setting to", x, y)

	for _,player in pairs(EntityGetWithTag("player_unit") or {}) do
		utils.SetInternalInt(player, "hardmod_return_portal_dest_x", x)
		utils.SetInternalInt(player, "hardmod_return_portal_dest_y", y)
	end
end
