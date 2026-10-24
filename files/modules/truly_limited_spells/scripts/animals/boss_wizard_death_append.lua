
local _death = death
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	_death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	
	local x, y = EntityGetTransform( GetUpdatedEntityID() )
	CreateItemActionEntity( "HARDMOD_SPELL_INFINITY", x, y - 8 )
end
