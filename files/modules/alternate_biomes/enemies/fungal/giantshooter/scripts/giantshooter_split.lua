dofile_once("mods/noita.hardmod/files/modules/alternate_biomes/enemies/fungal/spores/scripts/spore_burst.lua")

function damage_received(damage, desc, entity_who_caused, is_fatal)
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity_id)
	local comp = EntityGetFirstComponent(entity_id, "DamageModelComponent")
	if not comp then return end
	local health = ComponentGetValue2(comp, "hp")

	if health > 0.3 and health - damage < 0.3 then
		SetRandomSeed(GameGetFrameNum(), x + y + entity_id)
		for i = 1, 3 do
			local e = EntityLoad("mods/noita.hardmod/files/modules/alternate_biomes/enemies/fungal/slimeshooter/hardmod_fungal_slimeshooter.xml", x + Random(-10, 10), y + Random(-10, 10))
			local vel = EntityGetFirstComponent(e, "VelocityComponent")
			if vel then ComponentSetValue2(vel, "mVelocity", Random(-90, 90), Random(-150, 25)) end
		end
		spore_burst(entity_id, x, y - 6, 8)
	end
end
