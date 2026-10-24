dofile_once( "mods/noita.hardmod/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()
local wand_entity_id = EntityGetParent( entity_id )
local EZWand = dofile_once( "mods/noita.hardmod/lib/ezwand.lua" )

if wand_entity_id and EZWand.IsWand( wand_entity_id ) then
	local wand = EZWand( wand_entity_id )

	-- if wand.manaChargeSpeed > 100 then
	-- wand.mana = wand.mana + ( wand.manaMax * 0.0167 * 0.1 ) -- i.e. 10% of max mana
	-- else
	wand.mana = wand.mana + 1.667
	-- end
end
