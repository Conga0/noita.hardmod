
function shot(entity_id)
    -- local proj_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
    -- if proj_comp ~= nil then
    --     ComponentObjectSetValue2(proj_comp, "damage_by_type", "fire", 0.4)
    -- end
    -- local x, y = EntityGetTransform(entity_id)
    -- EntityAddChild(entity_id, EntityLoad("mods/noita.hardmod/files/modules/enemy_perks/entities/pyrelord_hitfx.xml", x, y))

    GamePrint("SHOOT")
    EntityAddComponent2(entity_id, "LuaComponent", {
    	script_source_file = "mods/noita.hardmod/files/modules/enemy_perks/scripts/aerolord_on_proj_death.lua",
    	execute_every_n_frame = -1,
    	execute_on_removed = true,
    })
end
