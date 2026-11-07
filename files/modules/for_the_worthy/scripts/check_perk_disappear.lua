local eid = GetUpdatedEntityID()
local x, y = EntityGetTransform(eid)

local check_x, check_y = 368, -108
-- local check_x = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_X")) or 227
-- local check_y = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_Y")) or -80

local player = EntityGetInRadiusWithTag(check_x, check_y, 300, "player_unit")[1]

if not player then
	EntityKill(eid)

	local emitter = EntityGetInRadiusWithTag(x, y, 10, "hardmod_hell_perk_emitter")[1]
	if emitter then
		local comp = EntityGetFirstComponent(emitter, "ParticleEmitterComponent")
		if comp then ComponentSetValue2(comp, "emitted_material_name", "spark_yellow") end
	end
end
