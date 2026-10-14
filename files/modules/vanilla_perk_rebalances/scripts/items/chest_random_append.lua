dofile_once( "mods/noita.hardmod/lib/utilities.lua" )

-- this is a clone of chest_load_gold_entity(), but it adds a tag to the entity
function spawn_gold_nugget( entity_filename, x, y, remove_timer )
	local eid = load_gold_entity( entity_filename, x, y, remove_timer )
	local item_comp = EntityGetFirstComponent( eid, "ItemComponent" )
	
	if item_comp ~= nil then
		if( ComponentGetValue2( item_comp, "auto_pickup") ) then
			ComponentSetValue2( item_comp, "next_frame_pickable", GameGetFrameNum() + 30 )	
		end
	end

	EntityAddTag( eid, "hardmod_treasure_hunter_skip" )
end

local _on_open = on_open
function on_open( entity_item )
	_on_open( entity_item )

	-- if the player has the Treasure Hunter perk, enhance chests to drop bonus gold
	local treasure_hunter_pickup_count = GetPerkPickupCount( "HARDMOD_TREASURE_HUNTER" )
	if treasure_hunter_pickup_count == 0 then return end

	-- Gold Is Forever compatibility, I guess
	local remove_gold_timer = false
	local comp_worldstate = EntityGetFirstComponent( GameGetWorldStateEntity(), "WorldStateComponent" )
	if( comp_worldstate ~= nil ) then
		if( ComponentGetValue2( comp_worldstate, "perk_gold_is_forever" ) ) then
			remove_gold_timer = true
		end
	end

	-- spawn extra gold, based on what the (nearest) player has picked up since the last chest
	local x, y = EntityGetTransform( entity_item )
	local nearest_player = EntityGetInRadiusWithTag( x, y, 100, "player_unit" )[1]
	if nearest_player == nil then return end

	local value_to_spawn = 100 + ( GetInternalInt( nearest_player, "hardmod_treasure_hunter_gold_saved" ) or 0 )
	value_to_spawn = value_to_spawn * treasure_hunter_pickup_count
	-- local value_to_spawn = 200 + ( ( ( spawn_y * 0.15 ) or ( y * 0.1 ) ) * treasure_hunter_pickup_count )
	-- above is an alternative, depth-based formula

	-- local spawn_y = GetInternalInt( entity_item, "hardmod_chest_y_at_spawn" )
	local nuggets_spawned = 0
	while ( value_to_spawn >= 10 ) and ( nuggets_spawned < 20 ) do
		local entity = "data/entities/items/pickup/goldnugget_10.xml"
		local value_spawned = 10

		if value_to_spawn >= 10000 then
			entity = "data/entities/items/pickup/goldnugget_10000.xml"
			value_spawned = 10000
		elseif value_to_spawn >= 1000 then
			entity = "data/entities/items/pickup/goldnugget_1000.xml"
			value_spawned = 1000
		elseif value_to_spawn >= 200 then
			entity = "data/entities/items/pickup/goldnugget_200.xml"
			value_spawned = 200
		elseif value_to_spawn >= 50 then
			entity = "data/entities/items/pickup/goldnugget_50.xml"
			value_spawned = 50
		end

		spawn_gold_nugget( entity, x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
		value_to_spawn = value_to_spawn - value_spawned
		nuggets_spawned = nuggets_spawned + 1
	end

	SetInternalInt( nearest_player, "hardmod_treasure_hunter_gold_saved", value_to_spawn )
end
