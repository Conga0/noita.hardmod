-- This is called from `ending/init.lua` on new runs

local x, y = 595, -90
local game_completed = HasFlagPersistent("hardmod_game_completed") or HasFlagPersistent("hardmod_false_game_completed")

local emitter = EntityLoad("mods/noita.hardmod/files/modules/for_the_worthy/entity/perk_emitter.xml", x, y)
local pec = EntityGetFirstComponent(emitter, "ParticleEmitterComponent")

if game_completed then
	EntityLoad("mods/noita.hardmod/files/modules/for_the_worthy/entity/perk.xml", x, y)

	if pec then
		ComponentSetValue2(pec, "emitted_material_name", "spark_red")
	end
end
