
local function try_apply_wand_experimenter_heal()
	local player = GetUpdatedEntityID()
	if not reflecting and player ~= 0 and #deck == 0 then
		-- start with lightest operations
		
		local pickup_count = tonumber( GlobalsGetValue( "PERK_PICKED_WAND_EXPERIMENTER_PICKUP_COUNT", "0" ) )
		if pickup_count > 0 then
			-- don't waste a heal if the player is wounded
			local is_wounded = GameGetGameEffect( player, "NO_HEAL" ) or 0
			if is_wounded == 0 then
				-- check if the wand has been edited
				local wand_entity = nil
				local was_edited = true
				local inv2_comp = EntityGetFirstComponentIncludingDisabled( player, "Inventory2Component" )
				if inv2_comp then
					local active_item = ComponentGetValue2( inv2_comp, "mActiveItem" )

					-- verify that the active item is a wand
					local acomp = EntityGetFirstComponentIncludingDisabled( active_item, "AbilityComponent" )
					if acomp and ComponentGetValue2( acomp, "use_gun_script" ) == true then
						wand_entity = active_item
						local edit_count = tonumber( ComponentGetValue2( acomp, "stat_times_player_has_edited") )
						if edit_count == 0 then
							was_edited = false
						end
					end
				end

				if wand_entity and not was_edited then
					local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua") ---@type utils
					local heals_applied = utils.GetInternalInt( wand_entity, "hardmod_experimenter_heal_applied" ) or 0
					if heals_applied < 5 then
						local dmg_comp = EntityGetFirstComponentIncludingDisabled( player, "DamageModelComponent" )
						if dmg_comp then
							local p_hp = ComponentGetValue2( dmg_comp, "hp" )
							local p_max_hp = ComponentGetValue2( dmg_comp, "max_hp" )

							-- don't waste a heal if the player has full hp
							if p_hp < p_max_hp then
								local heal = math.max( p_max_hp * 0.02, 0.4 ) -- heal up to 50 or 10% max HP, whichever is higher
								ComponentSetValue2( dmg_comp, "hp", math.min( p_hp + heal, p_max_hp ) )
								
								local x,y = EntityGetTransform( player )
								EntityLoad( "data/entities/particles/heal_effect.xml", x, y )

								-- make this wand heal only once
								utils.SetInternalInt( wand_entity, "hardmod_experimenter_heal_applied", heals_applied + 1 )
							end
						end
					end
				end
			end
		end
	end
end

local _move_hand_to_discarded = move_hand_to_discarded
function move_hand_to_discarded()
	_move_hand_to_discarded()
	try_apply_wand_experimenter_heal()
end
