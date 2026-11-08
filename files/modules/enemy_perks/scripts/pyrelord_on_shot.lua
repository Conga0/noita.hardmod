
function shot(entity_id)
	local x, y = EntityGetTransform(entity_id)
	EntityAddChild(entity_id, EntityLoad("mods/noita.hardmod/files/modules/enemy_perks/entities/pyrelord_hitfx.xml", x, y))

	local burn_vfx = EntityLoad("data/entities/misc/burn.xml", x, y)
	EntityAddComponent2(burn_vfx, "InheritTransformComponent", {})
	EntityAddChild(entity_id, burn_vfx)
end
