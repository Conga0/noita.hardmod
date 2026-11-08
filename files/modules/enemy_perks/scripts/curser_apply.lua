local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)

local initial_time = 600
local cooldown = 60
local amount_add_frames = 300
local reset_timer = true

for _,child in ipairs(EntityGetAllChildren(root) or {}) do
	local name = EntityGetName(child)
	if name == "hardmod.curse_cloud_thunder" or name == "hardmod.curse_cloud_acid" then
		local gec = EntityGetFirstComponent(child, "GameEffectComponent")
		if not gec then return end
		if reset_timer then
			ComponentSetValue2(gec, "frames", initial_time)
		else
			for _, varcomp in ipairs(EntityGetComponent(child, "VariableStorageComponent") or {}) do
				if ComponentGetValue2(varcomp, "name") == "last_time_incremented" then
					local frame = GameGetFrameNum()
					if ComponentGetValue2(varcomp, "value_int") > frame then return
					else
						ComponentSetValue2(varcomp, "value_int", frame+cooldown)
					end
				end
			end
			ComponentSetValue2(gec, "frames", ComponentGetValue2(gec, "frames") + amount_add_frames)
		end
		EntityKill(entity_id) return
	end
end

local x,y = EntityGetTransform(entity_id)
local effect = EntityLoad("mods/noita.hardmod/files/modules/enemy_perks/entities/curser_effect.xml", x, y)
EntityAddChild(root, effect)
local gec = EntityGetFirstComponent(effect, "GameEffectComponent")
if gec then ComponentSetValue2(gec, "frames", initial_time) end