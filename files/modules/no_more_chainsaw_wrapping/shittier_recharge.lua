-- Chainsaw wrappers in shambles
local wrappers = {
	CHAINSAW = true,
	LUMINOUS_DRILL = true,
}


local old_play_action = play_action
local chainsaw_abuser_list = {

}
local different_projectile_triggered = false

play_action = function(action, ...)

	-- Why did my chainsaw wrapped wand suddenly get slower? 
	-- I'll never tell :)

	-- this is hell code which makes chainsaw entirely useless in rapid fire wands.

	local was_abuser = false
	local min_delay = 30
	if(wrappers[action.id] and not reflecting)then
		local card = nil
		for _,e in ipairs( EntityGetWithTag( "card_action" ) ) do
			local item = EntityGetFirstComponentIncludingDisabled( e, "ItemComponent" )
			if item then
				if ComponentGetValue2( item, "mItemUid" ) == action.inventoryitem_id then
					card = e
				end
			end
		end
		if(card)then
			
			if(chainsaw_abuser_list[card] and GameGetFrameNum() - chainsaw_abuser_list[card] < min_delay and different_projectile_triggered)then
				was_abuser = true
			end
			chainsaw_abuser_list[card] = GameGetFrameNum()
		end
		different_projectile_triggered = false
	else
		-- cooldown
		if(action.type == ACTION_TYPE_PROJECTILE or action.type == ACTION_TYPE_STATIC_PROJECTILE)then
			different_projectile_triggered = true
		end
	end
	
	old_play_action(action, ...)
	if(was_abuser)then
		current_reload_time = current_reload_time + min_delay
	end	
end
