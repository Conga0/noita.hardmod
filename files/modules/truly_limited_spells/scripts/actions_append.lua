
local function hand_contains( hand, action_id )
	for i,card in ipairs( hand ) do
		if card.id == action_id then
			return true
		end
	end
	return false
end

local function get_actions_lua_data( action_id )
    dofile_once( "data/scripts/gun/gun_actions.lua" )
    for i,action in ipairs( actions ) do
        if action.id == action_id then
            return action
        end
    end
    return nil
end

local function find_action_entity_by_id( action_id )
	local all_cards = EntityGetWithTag( "card_action" )
	for i,card in ipairs( all_cards ) do
		if EntityGetValue( card, "ItemActionComponent", "action_id" ) == action_id then
			return card
		end
	end
	return nil
end

local function trigger_action_ungreeked( data, hand, rec )
	if ( data.uses_remaining ~= 0 ) then
		data.action( rec )
		data.uses_remaining = data.uses_remaining - 1
	-- if the cast contains HARDMOD_SPELL_INFINITY, cast the spell even with 0 uses remaining
	elseif ( data.uses_remaining == 0 ) and hand_contains( hand, "HARDMOD_SPELL_INFINITY" ) then
		data.action( rec )
	end

	local action_eid = find_action_entity_by_id( data.id )
	if action_eid ~= nil then
		local icomp = EntityGetFirstComponentIncludingDisabled( action_eid, "ItemComponent" )
		if icomp ~= nil then
		    uses_remaining = ComponentGetValue2( icomp, "uses_remaining" )
			if uses_remaining > 0 then
				data.action( rec )
				ComponentSetValue2( icomp, "uses_remaining", uses_remaining - 1 )

				if uses_remaining == 1 then
					local x, y = EntityGetTransform( GetUpdatedEntityID() )
					GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/action_consumed", x, y )
				end
			end
		end
	end
end

local function EntityIsWand( entity_id )
	local acomp = EntityGetFirstComponentIncludingDisabled( entity_id, "AbilityComponent" )
  	if not acomp then return false end
	return ComponentGetValue2( acomp, "use_gun_script" ) == true
end

local function GetHeldWand( entity_id )
	if entity_id ~= nil then
		local inv2_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "Inventory2Component" )
		local active_item = ComponentGetValue2( inv2_comp, "mActiveItem" )
		if EntityIsWand( active_item ) then
			return active_item
		end
	end
	return nil
end

local function EntityLoadAtWandTip( player_entity_id, load_this_entity )
    local wand_entity_id = GetHeldWand( player_entity_id )
    if ( not player_entity_id ) or ( not wand_entity_id ) then return end

    local ctrl_comp = EntityGetFirstComponent( player_entity_id, "ControlsComponent" )
    local hs_comp = EntityGetFirstComponentIncludingDisabled( wand_entity_id, "HotspotComponent" )
    if ctrl_comp ~= nil and hs_comp ~= nil then
        local aim_x, aim_y = ComponentGetValue2( ctrl_comp, "mAimingVectorNormalized" )
		local offset_x, offset_y = ComponentGetValue2( hs_comp, "offset" )
		local offset_mag = math.sqrt( offset_x ^ 2 + offset_y ^ 2 )

        local wx, wy = EntityGetTransform( wand_entity_id )
        local tx = wx + ( offset_mag * aim_x )
        local ty = wy + ( offset_mag * aim_y )
        return EntityLoad( load_this_entity, tx, ty )
    end
    return nil
end

if actions ~= nil then
	new_actions = {
		{
			id					= "HARDMOD_SPELL_INDULGENCE",
			name				= "$hardmod_spell_indulgence_name",
			description			= "$hardmod_spell_indulgence_desc",
			sprite				= "mods/noita.hardmod/files/modules/truly_limited_spells/gfx/ui_gfx/spells/indulgence.png",
			type				= ACTION_TYPE_OTHER,
			recursive 			= true,
			spawn_level			= "0",
			spawn_probability	= "0",
			spawn_requires_flag = "hardmod_cannot_spawn",
			price				= 1000,
			mana				= 1,
			action				= function()
									if reflecting then return end

									local data = {}
									if ( #deck > 0 ) then
										data = deck[1]
									elseif ( #hand > 0 ) then
										data = hand[1]
									else
										data = nil
									end

									local rec = check_recursion( data, recursion_level )
									
									if ( data ~= nil ) and ( rec > -1 ) and ( data.uses_remaining == 0 ) then

										-- determine the spell's max uses
										local max_uses = -1
										local lua_data = get_actions_lua_data( data.id )
										if lua_data.max_uses then
											max_uses = lua_data.max_uses
										end

										-- how much money does the player have?
										local player = GetUpdatedEntityID()
										local wcomp = EntityGetFirstComponent( player, "WalletComponent" )
										if wcomp == nil then return end
										local money = ComponentGetValue2( wcomp, "money" )

										-- determine the cost for this spell
										local cast_price
										if data.id == "DIVIDE_10" then
											cast_price = 500
										elseif max_uses <= 2 or data.recursive then -- i.e. Circle of Vigour, Greek letters
											cast_price = 250
										elseif max_uses <= 5 then -- i.e. Black Hole
											cast_price = 125
										elseif max_uses <= 10 then
											cast_price = 50
										elseif max_uses <= 20 then
											cast_price = 25
										else
											cast_price = 10
										end
										if lua_data.never_unlimited then
											cast_price = cast_price * 2
										end

										if money >= cast_price then
											ComponentSetValue2( wcomp, "money", money - cast_price )

											data.action( rec )
											mana = mana - data.mana

											local x, y = EntityGetTransform( GetUpdatedEntityID() )
											GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/goldnugget/create", x, y )
											if ModSettingGet( "noita.hardmod.print_indulgence_cost" ) == true then
												local cost_label = EntityLoadAtWandTip( GetUpdatedEntityID(), "mods/noita.hardmod/files/modules/truly_limited_spells/entities/misc/indulgence_cost_label.xml" )
												EntityAddComponent2( cost_label, "VariableStorageComponent", {
													name = "hardmod_indulgence_cast_price",
													value_int = cast_price,
												})
											end
										end
									else
										mana = mana + 40
										draw_actions( 1, true )
									end
								end,
		},
		{
			id					= "HARDMOD_SPELL_INFINITY",
			name				= "$hardmod_spell_infinity_name",
			description			= "$hardmod_spell_infinity_desc",
			sprite				= "mods/noita.hardmod/files/modules/truly_limited_spells/gfx/ui_gfx/spells/infinity.png",
			type				= ACTION_TYPE_OTHER,
			recursive 			= true,
			spawn_level			= "0",
			spawn_probability	= "0",
			spawn_requires_flag = "hardmod_cannot_spawn",
			price				= 800,
			mana				= 99,
			action				= function()
									if reflecting then return end

									local data = {}
									if ( #deck > 0 ) then
										data = deck[1]
									elseif ( #hand > 0 ) then
										data = hand[1]
									else
										data = nil
									end

									local rec = check_recursion( data, recursion_level )
									
									if ( data ~= nil ) and ( rec > -1 ) and ( data.uses_remaining == 0 ) then
										data.action( rec )
										mana = mana - data.mana
									else
										mana = mana + 100
										draw_actions( 1, true )
									end
								end,
		},
	}

	reworked_actions = {
	    ["ALPHA"] = {
	    	max_uses = 30,
	    	never_unlimited = true,
	    },

	    ["GAMMA"] = {
	    	max_uses = 30,
	    	never_unlimited = true,
	    },

	    ["TAU"] = {
	    	max_uses = 30,
	    	never_unlimited = true,
	    },

	    ["OMEGA"] = {
	    	max_uses = 30,
	    	never_unlimited = true,
	    },

	    ["MU"] = {
	    	max_uses = 30,
	    	never_unlimited = true,
	    },

	    ["PHI"] = {
	    	max_uses = 30,
	    	never_unlimited = true,
	    },

	    ["SIGMA"] = {
	    	max_uses = 30,
	    	never_unlimited = true,
	    },

	    ["APOTHEOSIS_CHI"] = {
	    	max_uses = 30,
	    	never_unlimited = true,
	    },

	    ["APOTHEOSIS_KAPPA"] = {
	    	max_uses = 30,
	    	never_unlimited = true,
	    },

	    ["ZETA"] = {
			max_uses = 30,
			never_unlimited = true,
	    },

	    ["RESET"] = {
	    	spawn_level = "0",
	    	spawn_probability = "0",
	    },
	}

	for i=1, #new_actions do
		table.insert( actions, new_actions[i] )
	end

	for i=1,#actions do
        if reworked_actions[actions[i].id] then
            for key, value in pairs( reworked_actions[actions[i].id] ) do
                actions[i][key] = value
            end
            actions[i]['hardmod_reworked'] = true
        end
    end
end
