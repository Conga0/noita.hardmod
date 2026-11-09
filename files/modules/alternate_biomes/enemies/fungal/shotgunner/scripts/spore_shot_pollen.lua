local POLLEN_SPEED = 70

local entity_id = GetUpdatedEntityID()
local velocity = EntityGetFirstComponent(entity_id, "VelocityComponent")
if velocity == nil then
	return
end

local vx, vy = ComponentGetValue2(velocity, "mVelocity")
if vx * vx + vy * vy > POLLEN_SPEED * POLLEN_SPEED then
	return
end

ComponentSetValue2(velocity, "air_friction", 2.8)

local homing = EntityGetFirstComponentIncludingDisabled(entity_id, "HomingComponent")
if homing then
	EntitySetComponentIsEnabled(entity_id, homing, true)
end

EntitySetComponentIsEnabled(entity_id, GetUpdatedComponentID(), false)
