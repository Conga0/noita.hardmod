local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua") ---@type utils

function enabled_changed( entity_id, state )
	if state then
		utils.SetInternalInt( entity_id, "hardmod_last_wand_enable_frame", GameGetFrameNum() )
	else
		utils.SetInternalInt( entity_id, "hardmod_last_wand_disable_frame", GameGetFrameNum() )
	end

	local last_enable_frame = utils.GetInternalInt( entity_id, "hardmod_last_wand_enable_frame" ) or 30
	local last_disable_frame = utils.GetInternalInt( entity_id, "hardmod_last_wand_disable_frame" ) or 0
	-- GamePrint( "enable:  " .. last_enable_frame )
	-- GamePrint( "disable: " .. last_disable_frame )
	local wand_swap_back_time = math.abs( last_enable_frame - last_disable_frame )

	local owner = EntityGetRootEntity( entity_id )
	local vsc = EntityGetFirstComponentIncludingDisabled( owner, "VariableStorageComponent", "hardmod_wand_spells_cast" )
	local inv2 = EntityGetFirstComponent( owner, "Inventory2Component" )
	if not vsc then return end
	if not inv2 then return end

	-- do not incur reload upon swapping *into* a wand
	-- if state then return end

	local spells_cast = ( ComponentGetValue2( vsc, "value_int" ) or 0 )
	-- local incur_any_recharge = 
	local incur_full_recharge = ( state ) and ( wand_swap_back_time < 5 ) and ( spells_cast > 0 )
	-- local incur_half_recharge = ( not state ) and ( wand_swap_back_time > 5 ) and ( spells_cast > 0 )
	-- GamePrint( wand_swap_back_time .. " (incur full: " .. tostring( incur_full_recharge ) .. " / incur half: " .. tostring( incur_half_recharge ) )

	if incur_full_recharge
	-- or incur_half_recharge
	then
		ComponentSetValue2( inv2, "mDontLogNextItemEquip", true )
		ComponentSetValue2( inv2, "mForceRefresh", true )
		ComponentSetValue2( inv2, "mActualActiveItem", 0 )

		local acomp = EntityGetFirstComponentIncludingDisabled( entity_id, "AbilityComponent" )
		local reload_time = EntityGetFirstComponentIncludingDisabled( owner, "VariableStorageComponent", "hardmod_wand_reload_time" ) or -1
		if reload_time == -1 then
			local EZWand = dofile_once( "mods/noita.hardmod/lib/ezwand.lua" )
			reload_time = EZWand( entity_id ).rechargeTime
		end

		-- GamePrint( "a: " .. reload_time * 0.0167 )

		-- if the player had fired a shot before manually swapping, incur less recharge time
		-- if incur_half_recharge then
		-- 	reload_time = reload_time - math.max( reload_time * 0.5, 60 )
		-- end

		-- GamePrint( "b: " .. reload_time * 0.0167 )

		-- only reload if the wand isn't already reloading
		local next_frame_usable = ComponentGetValue2( acomp, "mReloadNextFrameUsable" )
		if GameGetFrameNum() >= next_frame_usable then
			ComponentSetValue2( acomp, "mReloadNextFrameUsable", GameGetFrameNum() + reload_time )
			ComponentSetValue2( acomp, "mReloadFramesLeft", reload_time )
			ComponentSetValue2( acomp, "reload_time_frames", reload_time )
		end

		if reload_time > 60 then
			local x, y = EntityGetTransform( owner )
			GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/recharging", x, y )
			GamePrint( "$hardmod_gameprint_instant_recharge_fail" )
		end

		ComponentSetValue2( vsc, "value_int", 0 )
	end
end
