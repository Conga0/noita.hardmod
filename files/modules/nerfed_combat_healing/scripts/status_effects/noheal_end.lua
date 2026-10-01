
local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)
local x,y = EntityGetTransform(entity_id)
EntityGetTransform(target)

local c = EntityLoad("mods/Apotheosis/files/entities/misc/hitfx_nohealing_remove.xml", x, y)
EntityAddChild(target,c)
