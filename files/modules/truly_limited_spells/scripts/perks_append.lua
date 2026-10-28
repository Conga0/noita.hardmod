---@diagnostic disable: undefined-global
perk_reworks = {
	["UNLIMITED_SPELLS"] = {
		not_in_default_perk_pool = true,
	},
}

new_perks = {
	{
		id = "HARDMOD_PERK_SPELL_GEMS",
		ui_name = "$hardmod_perk_spell_gems_name",
		ui_description = "$hardmod_perk_spell_gems_desc",
		ui_icon = "mods/noita.hardmod/files/modules/truly_limited_spells/gfx/ui_gfx/perks/spell_gems_016.png",
		perk_icon = "mods/noita.hardmod/files/modules/truly_limited_spells/gfx/ui_gfx/perks/spell_gems.png",
		stackable = STACKABLE_NO,
		one_off_effect = false,
		usable_by_enemies = false,
        func = function( entity_perk_item, entity_who_picked, item_name )
            EntityAddChild( entity_who_picked, EntityLoad( "mods/noita.hardmod/files/modules/truly_limited_spells/entities/perks/spell_gems.xml" ) )
        end,
        func_remove = function( entity_who_picked )
        	local perk_entity = EntityGetAllChildren( entity_who_picked, "hardmod_spell_gems_perk_entity" )[1]
			if perk_entity ~= nil then
				EntityKill( perk_entity )
			end
        end,
	},
}

if perk_list ~= nil then
	for _,perk in pairs(perk_list) do
		if perk_reworks[perk.id] then
			for k,v in pairs(perk_reworks[perk.id]) do
				perk[k] = v
			end
		end
	end

	for k, v in pairs( new_perks ) do
		table.insert( perk_list, v )
	end
end
