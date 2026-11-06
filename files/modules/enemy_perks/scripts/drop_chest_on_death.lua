function death(damage_type_bit_field, message, attacker, drop_items)
    local entity_id = GetUpdatedEntityID()
    local x,y = EntityGetTransform(entity_id)
    if EntityHasTag(entity_id, "boss") then
        EntityLoad("data/entities/items/pickup/chest_random_super.xml", x, y)
    else
        EntityLoad("data/entities/items/pickup/chest_random.xml")
    end
end