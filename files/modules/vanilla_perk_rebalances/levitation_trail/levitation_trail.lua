local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua") ---@type utils

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local comp = EntityGetFirstComponent(entity_id, "CharacterPlatformingComponent")

if comp == nil or ComponentGetValue2(comp, "mJetpackEmitting") < 1 then
	return
end

local vel_x, vel_y = GameGetVelocityCompVelocity(entity_id)
vel_x = -vel_x * 75
vel_y = -vel_y * 50
utils.ShootProjectile(entity_id, "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/levitation_trail/levitation_projectile.xml", pos_x, pos_y, vel_x, vel_y)