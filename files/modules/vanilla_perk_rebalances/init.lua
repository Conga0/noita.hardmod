local hooks = {}
local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

local lootlib = dofile_once("mods/noita.hardmod/lib/lootlib.lua") ---@type lootlib
lootlib.add_patch_script("mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/lootlib_patch.lua")

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

local function modify_xray()
	local path = "data/entities/projectiles/deck/xray.xml"
	local xml = nxml.parse( ModTextFileGetContent( path ) )
	local proj_comp = xml:first_of("ProjectileComponent")
	if proj_comp then
		proj_comp:set( "lifetime", 30 )
	end
	ModTextFileSetContent( path, tostring(xml) )
end

local function modify_wand_experimenter()
	for file in nxml.edit_file("data/entities/base_wand.xml") do
		file:create_child("LuaComponent", {
			_enabled = true,
			execute_every_n_frame = 2,
			remove_after_executed = true,
			script_source_file = "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/perks/wand_experimenter/init.lua"
		})
	end

	ModLuaFileAppend("data/scripts/perks/wand_experimenter.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/perks/wand_experimenter/append.lua")
end

hooks.mod_init = function()
	modify_master_of_blinding()
	modify_wandstone()
	modify_mountain_altar()
	modify_xray()
	modify_wand_experimenter()
end

hooks.mod_post_init = function()
	ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/appends/perk_list.lua")
	ModLuaFileAppend("data/scripts/perks/perk.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/appends/perk.lua")
	ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/appends/actions.lua")
	ModLuaFileAppend("data/scripts/item_spawnlists.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/appends/item_spawnlists.lua")
	-- ModLuaFileAppend("data/scripts/magic/altar_tablet_magic.lua", "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/appends/altar_tablet_magic.lua")
end

hooks.player_spawned = function ()
	EntityLoad("mods/noita.hardmod/files/modules/vanilla_perk_rebalances/entities/items/cheese.xml", 0, -10)
end

return hooks
