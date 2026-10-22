dofile_once( "mods/noita.hardmod/lib/utilities.lua" )

local _item_pickup = item_pickup
function item_pickup( entity_item, entity_who_picked, item_name )
	_item_pickup( entity_item, entity_who_picked, item_name )

	if GetPerkPickupCount( "HARDMOD_TREASURE_HUNTER" ) > 0 and not EntityHasTag( entity_item, "hardmod_treasure_hunter_skip" ) then
		local nugget_value = GetInternalInt( entity_item, "gold_value" ) or 10

		local gold_saved = GetInternalInt( entity_who_picked, "hardmod_treasure_hunter_gold_saved" ) or 0
		SetInternalInt( entity_who_picked, "hardmod_treasure_hunter_gold_saved", gold_saved + nugget_value )
	end
end
