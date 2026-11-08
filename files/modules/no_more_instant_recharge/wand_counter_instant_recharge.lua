
function enabled_changed( entity_id, state )
	if state then return end

	local wand_entity = GetUpdatedEntityID()
	local owner = EntityGetRootEntity( wand_entity )
	local vsc = EntityGetFirstComponentIncludingDisabled( owner, "VariableStorageComponent", "hardmod_wand_spells_cast" )
	if vsc and ( ComponentGetValue2( vsc, "value_int" ) or 0 ) > 0 then

		local inv2 = EntityGetFirstComponent( owner, "Inventory2Component" )
		if inv2 ~= nil then
			if inv2 then
				-- This will only skip 1 equip message, but it's better than nothing
				ComponentSetValue2( inv2, "mDontLogNextItemEquip", true )
			end

			ComponentSetValue2( inv2, "mForceRefresh", true )
			ComponentSetValue2( inv2, "mActualActiveItem", 0 )

			local EZWand = dofile_once( "mods/noita.hardmod/lib/ezwand.lua" )
			local wand = EZWand( wand_entity )

			local acomp = EntityGetFirstComponentIncludingDisabled( wand_entity, "AbilityComponent" )
			local reload_time = wand.rechargeTime

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
			end
		end

		ComponentSetValue2( vsc, "value_int", 0 )
	end
end
