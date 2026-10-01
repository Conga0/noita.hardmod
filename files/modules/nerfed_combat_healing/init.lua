local hooks = {
	--Game/World Initialising
	mod_pre_init = function() end,
	mod_init = function() end,
	mod_post_init = function() end,
	magic_numbers_and_seed_initialised = function() end, --OnMagicNumbersAndWorldSeedInitialised
	edit_material = function(elem) end, --iterates over all materials OnMagicNumbersAndWorldSeedInitialised
	edit_reaction = function(elem) end, --iterates over all reactions OnMagicNumbersAndWorldSeedInitialised
	biome_config = function() end,
	world_init = function() end,

	--Runtime hofunction() ends
	pre_update = function(frame) end, --beginning of every frame
	new_eid = function(entity_id) end, --new entity
	post_update = function(frame) end, --end of every frame

	--Player hofunction() ends
	player_spawned = function(player) end, --When the player spawns in after world is initialised
	player_changed = function(player, poly_identity) end, --Runs whenever polymorphing/unpolymorphing
	player_destroyed = function(player) end, --OnPlayerDied

	--Pause hofunction() ends
	mod_settings_changed = function() end,
	pause_pre_update = function(is_paused, is_inventory_pause) end,
	pause_changed = function() end,
	count_secrets = function(total, found) return total,found end,
}

hooks.mod_init = function()
    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
	local path = "data/entities/player_base.xml"
	local xml = nxml.parse(ModTextFileGetContent(path))
    
	xml:add_child(nxml.parse([[
        <LuaComponent
        _enabled="1"
        script_damage_received="mods/noita.hardmod/files/modules/nerfed_combat_healing/scripts/wound_on_damage.lua"
        execute_every_n_frame="-1"
        >
        </LuaComponent>
    ]]))
	ModTextFileSetContent(path, tostring(xml))

	-- Modular translation injection
	-- local translations_filepath = "mods/noita.hardmod/files/standard.csv"
	-- local translations = ModTextFileGetContent(translations_filepath)
	-- local new_translations = ModTextFileGetContent("mods/noita.hardmod/files/modules/anti_cov_spam/translations.csv")
	-- translations = translations .. "\n" .. new_translations .. "\n"
	-- ModTextFileSetContent(translations_filepath, translations)
end

return hooks --Don't forget to do this if you want your changes to apply!!!!