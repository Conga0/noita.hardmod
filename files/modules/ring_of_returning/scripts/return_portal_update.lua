dofile_once( "mods/noita.hardmod/lib/utilities.lua" )

local portal_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( portal_id )

-- destroy the portal if the player is more than 300 units away from it
local nearby_players = EntityGetInRadiusWithTag( x, y, 300, "player_unit" )
if nearby_players == nil or #nearby_players == 0 then
	EntityKill( portal_id )
end
