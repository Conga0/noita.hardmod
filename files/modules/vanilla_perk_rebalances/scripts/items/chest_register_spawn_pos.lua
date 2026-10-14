dofile_once( "mods/noita.hardmod/lib/utilities.lua" )

local sx, sy = EntityGetTransform( GetUpdatedEntityID() )
SetInternalInt( GetUpdatedEntityID(), "hardmod_chest_y_at_spawn", sy )