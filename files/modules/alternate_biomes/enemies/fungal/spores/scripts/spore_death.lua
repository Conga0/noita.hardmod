dofile_once("mods/noita.hardmod/files/modules/alternate_biomes/enemies/fungal/spores/scripts/spore_burst.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity_id)
	spore_burst(entity_id, x, y - 4, spore_count(entity_id, 6))
end
