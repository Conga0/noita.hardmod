dofile_once("mods/noita.hardmod/files/modules/alternate_biomes/enemies/fungal/spores/scripts/spore_burst.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

spore_burst(entity_id, x, y, spore_count(entity_id, 6))
EntityKill(entity_id)
