local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

local module = {}

for entity in nxml.edit_file("data/entities/items/pickup/heart_fullhp_temple.xml") do
	-- Nah you aren't getting max hp from this, earn it like a real gamer
	local base = entity:first_of("Base")

	for i = #base.children, 1, -1 do
		if base.children[i]:get("script_item_picked_up") == "data/scripts/items/heart_fullhp_temple.lua" then
			base.children[i]:set("script_item_picked_up", "data/scripts/items/heart_fullhp.lua")
		end
	end

	for i = #entity.children, 1, -1 do
		if entity.children[i]:get("script_collision_trigger_hit") == "data/scripts/items/heart_fullhp_temple.lua" then
			entity.children[i]:set("script_collision_trigger_hit", "data/scripts/items/heart_fullhp.lua")
		end		
	end
end

return module