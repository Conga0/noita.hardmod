dofile_once( "mods/noita.hardmod/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()
local wand_entity_id = EntityGetParent( entity_id )
local EZWand = dofile_once( "mods/noita.hardmod/lib/ezwand.lua" )

if wand_entity_id and EZWand.IsWand( wand_entity_id ) then
	local wand = EZWand( wand_entity_id )
	wand.mana = wand.mana + ( wand.manaMax * 0.0167 * 0.125 ) -- i.e. 12.5% of max mana
end
