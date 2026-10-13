local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)

local enemy_perks_indexed = dofile_once("mods/noita.hardmod/files/modules/enemy_perks/enemy_perks_index.lua")

local enemy_perk_data
for _,varcomp in ipairs(EntityGetComponent(entity_id, "VariableStorageComponent") or {}) do
	if ComponentGetValue2(varcomp, "name") == "enemy_perk_data" then enemy_perk_data = varcomp break end
end

local function update_icons()
	local offset_y = 0
	for _,hitbox in ipairs(EntityGetComponent(root, "HitboxComponent") or {}) do
		offset_y = math.max(offset_y, -ComponentGetValue2(hitbox, "aabb_min_y"))
	end
	offset_y = offset_y + 14

	for _,spr_comp in ipairs(EntityGetComponent(entity_id, "SpriteComponent") or {}) do
		EntityRemoveComponent(entity_id, spr_comp)
	end

	local enemy_perks = {}
	for perk_id in ComponentGetValue2(enemy_perk_data, "value_string"):gmatch("([^,]+)") do
		enemy_perks[#enemy_perks+1] = enemy_perks_indexed[perk_id]
	end

	local num_icons = math.min(#enemy_perks, 3)
	for i=1,num_icons do
		local sprite = (i == 3 and #enemy_perks > 3) and "mods/noita.hardmod/files/modules/enemy_perks/expand.png" or enemy_perks[i].icon
		EntityAddComponent2(entity_id, "SpriteComponent", {
			offset_x = (i*5-num_icons*2.5),
			offset_y = offset_y,
			image_file = sprite,
		})
	end
end

function init(eid)
	local self = GetUpdatedComponentID()
	ComponentSetValue2(self, "mNextExecutionTime", GameGetFrameNum() + 1)
end


--update_icons()