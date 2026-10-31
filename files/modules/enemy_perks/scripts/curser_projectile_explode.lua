local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

print("a")
local largest_radius = 0
for _,proj_comp in ipairs(EntityGetComponent(entity_id, "ProjectileComponent") or {}) do
	print("b")
	largest_radius = math.max(largest_radius, ComponentObjectGetValue2(proj_comp, "config_explosion", "explosion_radius"))
end

for _,entity in ipairs(EntityGetInRadiusWithTag(x, y, largest_radius, "mortal")) do
	print("c")
	local ex,ey = EntityGetTransform(entity)
	print("checking "..entity)
	if not RaytraceSurfaces(x, y, ex,ey) then
		print("path clear, YAY!")
		EntityAddChild(entity, EntityLoad("mods/noita.hardmod/files/modules/enemy_perks/entities/curser_apply.xml", ex, ey))
	end
end