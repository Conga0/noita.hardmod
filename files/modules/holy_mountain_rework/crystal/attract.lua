local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

local strength = 12
local dampening = 3

for i,crystal in ipairs(EntityGetInRadiusWithTag(x, y, 65, "worm_crystal") or {}) do
	local cx,cy = EntityGetTransform(crystal)
	local distance = math.sqrt((cx-x)^2 + (cy-y)^2)
	local dir = 0 - math.atan2(y - cy, x - cx)
	local vx,vy = math.floor(math.cos(dir) * strength), math.floor(0 - math.sin(dir) * strength)
	local velx,vely = vx * distance/65, vy * distance/65

	PhysicsApplyForce(crystal, velx, vely)
end