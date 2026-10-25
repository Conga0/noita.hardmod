dofile_once("mods/noita.hardmod/lib/utilities.lua")

local orig_item_pickup = item_pickup
function item_pickup(item, picked_by, name)
	orig_item_pickup(item, picked_by, name)

	if GetPerkPickupCount("HARDMOD_TREASURE_HUNTER") > 0 and not EntityHasTag(item, "lootlib_chest_gold") then
		local nugget_value = GetInternalInt(item, "gold_value") or 10
		local gold_saved = GetInternalInt(picked_by, "hardmod_treasure_hunter_gold_saved") or 0

		SetInternalInt(picked_by, "hardmod_treasure_hunter_gold_saved", gold_saved + nugget_value)
	end
end
