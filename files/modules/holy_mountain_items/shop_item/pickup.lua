function item_pickup(eid, player)
	local x, y = EntityGetTransform(eid)
	local cid = GetUpdatedComponentID()

	local path = ComponentGetValue2(cid, "script_pressure_plate_change")
	EntityKill(eid)

	if not path or not ModDoesFileExist(path) then
		print("item picked up without actual entity path!!!")
		return
	end

	local item = EntityLoad(path, x, y)
	GamePickUpInventoryItem(player, item, false)

	EntityLoad("data/entities/particles/image_emitters/shop_effect.xml", x, y)
end
