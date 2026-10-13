local hooks = {}
local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

-- xml modifications as separate functions for better readability
local function modify_master_of_blinding()
	for xml in nxml.edit_file("data/entities/animals/wizard_dark.xml") do
		xml:add_child(nxml.new_element("LuaComponent", {
			script_source_file="mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/wizard_dark_ase_scan.lua",
        	execute_every_n_frame="2",
		}))
	end
end

local function modify_wandstone()
	for xml in nxml.edit_file("data/entities/items/pickup/wandstone.xml") do
		local tags = xml.attr.tags
		if #tags == 0 then xml.attr.tags = "hardmod_wandstone"
		else xml.attr.tags = tags .. ",hardmod_wandstone" end
    end
end

local function modify_mountain_altar()
	for xml in nxml.edit_file("data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml") do
		xml:add_child(nxml.new_element("LuaComponent", {
        	script_source_file="mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/altar_tablet_magic_append.lua",
        	execute_every_n_frame="240",
		}))
	end
end

hooks.mod_init = function()
	modify_master_of_blinding()
	modify_wandstone()
	modify_mountain_altar()
end

hooks.mod_post_init = function()
	ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/perks_append.lua")
	ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/actions_append.lua")
	ModLuaFileAppend("data/entities/animals/boss_wizard/death.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/boss_wizard_death_append.lua")
	-- ModLuaFileAppend("data/scripts/magic/altar_tablet_magic.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/altar_tablet_magic_append.lua")
end

return hooks --Don't forget to do this if you want your changes to apply!!!!