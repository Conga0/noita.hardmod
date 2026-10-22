dofile_once( "mods/noita.hardmod/lib/utilities.lua" )

local ring = GetUpdatedEntityID()
local x, y = EntityGetTransform( ring )
SetInternalInt( ring, "hardmod_spawn_x", x )
SetInternalInt( ring, "hardmod_spawn_y", y )
