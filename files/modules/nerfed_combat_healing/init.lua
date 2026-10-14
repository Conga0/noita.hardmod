local hooks = {}
local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

hooks.mod_init = function()
	for xml in nxml.edit_file("data/entities/player_base.xml") do
		xml:add_child(nxml.new_element("LuaComponent", {
			script_damage_received = "mods/noita.hardmod/files/modules/nerfed_combat_healing/scripts/wound_on_damage.lua",
		}))
	end

	-- Modular translation injection
	-- local translations_filepath = "mods/noita.hardmod/files/standard.csv"
	-- local translations = ModTextFileGetContent(translations_filepath)
	-- local new_translations = ModTextFileGetContent("mods/noita.hardmod/files/modules/anti_cov_spam/translations.csv")
	-- translations = translations .. "\n" .. new_translations .. "\n"
	-- ModTextFileSetContent(translations_filepath, translations)
end

return hooks --Don't forget to do this if you want your changes to apply!!!!