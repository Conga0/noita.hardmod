local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

local module = {

}

module.mod_pre_init = function()
	local igniters = {"data/entities/props/physics/trap_ignite.xml", "data/entities/props/physics/trap_ignite_enabled.xml", "data/entities/props/physics_trap_ignite.xml", "data/entities/props/physics_trap_ignite_enabled.xml"}
	for _, file in ipairs(igniters)do
		for entity in nxml.edit_file(file) do
			-- ignite instantly?
			for i = #entity.children, 1, -1 do
				if entity.children[i]:get("script_source_file") == "data/scripts/props/physics_trap_ignite.lua" then
					entity.children[i]:set("execute_every_n_frame", 1)
				end
			end
			
			local physics_body_comp = entity:first_of("PhysicsBodyComponent")

			if(physics_body_comp)then
				physics_body_comp:set("is_static", true)
			end

			local physics_body2_comp = entity:first_of("PhysicsBody2Component")

			if(physics_body2_comp)then
				physics_body2_comp:set("is_static", true)
			end
		end
	end


	local electifiers = {"data/entities/props/physics/trap_electricity.xml", "data/entities/props/physics/trap_electricity_enabled.xml", "data/entities/props/physics/trap_electricity_suspended.xml", "data/entities/props/physics_trap_electricity.xml", "data/entities/props/physics_trap_electricity_enabled.xml"}
	for _, file in ipairs(electifiers)do
		for entity in nxml.edit_file(file) do
			-- This might be too evil but honestly.. I hate how easily electrical traps are cheesed.
			for i = #entity.children, 1, -1 do
				if entity.children[i]:get("script_source_file") == "data/scripts/props/physics_trap_electricity_pulse.lua" then
					entity.children[i]:set("execute_every_n_frame", entity.children[i]:get("execute_every_n_frame") / 3)
				end
			end
			
			local physics_body_comp = entity:first_of("PhysicsBodyComponent")

			if(physics_body_comp)then
				physics_body_comp:set("is_static", true)
			end

			local physics_body2_comp = entity:first_of("PhysicsBody2Component")

			if(physics_body2_comp)then
				physics_body2_comp:set("is_static", true)
			end
		end
	end

	local acid_traps = {"data/entities/props/physics/trap_circle_acid.xml", "data/entities/props/physics_trap_circle_acid.xml"}

	for _, file in ipairs(acid_traps)do
		for entity in nxml.edit_file(file) do
			-- Make them unkickable, why does nolla let you get away with this.
			local physics_body_comp = entity:first_of("PhysicsBodyComponent")

			if(physics_body_comp)then
				physics_body_comp:set("is_static", true)
			end

			local physics_body2_comp = entity:first_of("PhysicsBody2Component")

			if(physics_body2_comp)then
				physics_body2_comp:set("is_static", true)
			end
		end
	end


end



return module