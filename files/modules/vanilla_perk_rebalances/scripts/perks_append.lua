perk_reworks = {
	{
		id = "REMOVE_FOG_OF_WAR",
		ui_name = "$hardmod_perk_all_seeing_eye_name",
		ui_description = "$hardmod_perk_all_seeing_eye_desc",
		ui_icon = "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/ui_gfx/perks/all_seeing_eye_016.png",
		perk_icon = "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/ui_gfx/perks/all_seeing_eye.png",
		clear_original_game_effect = true,
		stackable = STACKABLE_NO,
		one_off_effect = false,
		usable_by_enemies = false,
        func = function( entity_perk_item, entity_who_picked, item_name )
            EntityAddChild( entity_who_picked, EntityLoad( "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/entities/all_seeing_eye.xml" ) )
        end,
        func_remove = function( entity_who_picked )
        	local perk_entity = EntityGetAllChildren( entity_who_picked, "hardmod_all_seeing_eye_rework" )[1]
			if perk_entity ~= nil then
				EntityKill( perk_entity )
			end
        end,
	},
}

local function modify_perk( rework_data )
	for i = 1, #perk_list do
		local perk = perk_list[i]
		if perk.id == rework_data.id then
			for k, v in pairs( rework_data ) do
                if k ~= "id" then
                    perk[k] = v
                end
            end
            if rework_data.clear_original_game_effect then
            	perk.game_effect = nil
            end
            if rework_data.clear_original_game_effect2 then
            	perk.game_effect2 = nil
            end
        end
	end
end

if ( perk_list ~= nil ) then
	for k, v in pairs( perk_reworks ) do
		modify_perk( v )
	end
end