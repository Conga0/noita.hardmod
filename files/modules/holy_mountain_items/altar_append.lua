RegisterSpawnFunction(0xff6411ff, "hardmod_spawn_purchasable_item")
dofile_once("mods/noita.hardmod/files/modules/holy_mountain_items/shop_item/spawn.lua")

function spawn_hp(x, y)
	EntityLoad("data/entities/buildings/music_trigger_temple.xml", x-16, y)

	EntityLoad("mods/noita.hardmod/files/modules/holy_mountain_items/entities/heal_shop.xml", x-16, y)
	EntityLoad("mods/noita.hardmod/files/modules/holy_mountain_items/entities/spell_refresh_shop.xml", x+16, y)
end

local old_spawn_all_shopitems = spawn_all_shopitems

function spawn_all_shopitems(x, y, ...)
	old_spawn_all_shopitems(x,y,...)

	do return end
	local levels = {
		2,
		5,
		9,
		12,
		16,
		20,
		25,
	}

	local y_chunk_level = math.floor(y/512)
	local hm_level = 0
	for i,stage_boundary in ipairs(levels) do
		if stage_boundary > y_chunk_level then break end
		hm_level = i
	end

	if hm_level == 6 then
		local indexed_gun_actions = dofile_once("mods/noita.hardmod/lib/gun_actions_indexed.lua")
		local shop_items = {}
		local nearby_spells = EntityGetInRadiusWithTag(x+256, y+256, 300, "card_action")
		local nearby_wands = EntityGetInRadiusWithTag(x+256, y+256, 300, "wand")
		for _,item in ipairs(nearby_spells) do
			local cost_component = EntityGetFirstComponent(item, "ItemCostComponent")
			if cost_component then
				shop_items[#shop_items+1] = {item, cost_component, true}
			end
		end
		for _,item in ipairs(nearby_wands) do
			local cost_component = EntityGetFirstComponent(item, "ItemCostComponent")
			if cost_component then
				local ability_component = EntityGetFirstComponentIncludingDisabled(item, "AbilityComponent")
				if not ability_component then goto continue end

				if ability_component and ComponentObjectGetValue2(ability_component, "gun_config", "deck_capacity") < #(EntityGetAllChildren(item, "card_action") or {}) then
					nearby_wands[#nearby_wands+1] = {item, cost_component, false, ability_component}
				end
			end
			::continue::
		end

		for _=1, #shop_items do
			local target = Random(1, #shop_items)
			if target[3] then
				--spell handling
			else
				--wand handling
			end
		end
	end
end