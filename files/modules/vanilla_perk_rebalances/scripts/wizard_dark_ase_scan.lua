local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua") ---@type utils

local x, y = EntityGetTransform( GetUpdatedEntityID() )

local ase_entities = EntityGetWithTag( "hardmod_all_seeing_eye_entity" )
if ase_entities ~= nil and #ase_entities > 0 then
	local ase_entity = ase_entities[1]
	local ex, ey = EntityGetTransform( ase_entity )

	dofile_once("data/scripts/lib/utilities.lua")
	local dist = get_distance( x, y, ex, ey )
	if dist < 32 then
		EntitySetComponentsWithTagEnabled( ase_entity, "fog_of_war_hole", false )
	else
		EntitySetComponentsWithTagEnabled( ase_entity, "fog_of_war_hole", true )
	end
end
