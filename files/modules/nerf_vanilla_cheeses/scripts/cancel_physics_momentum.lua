local entity_id = GetUpdatedEntityID()
local pbc = EntityGetFirstComponentIncludingDisabled(entity_id, "PhysicsBodyComponent") or EntityGetFirstComponentIncludingDisabled(entity_id, "PhysicsBody2Component")
if not pbc then return end
local x,y,a,vx,vy,va = PhysicsComponentGetTransform(pbc)
PhysicsComponentSetTransform(pbc, x, y, a, 0, 0, va)