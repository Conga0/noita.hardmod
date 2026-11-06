local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua")---@type nxml
local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua")---@type utils
local alt_biomes = dofile_once("mods/noita.hardmod/files/modules/alternate_biomes/biome_list.lua")[1]

local dir = "mods/noita.hardmod/files/modules/alternate_biomes/"

ModMaterialsFileAdd(dir.."materials/materials.xml")
ModLuaFileAppend("mods/noita.hardmod/lib/biome_index.lua",
	dir.."scripts/append_biomes_to_index.lua"
)
ModLuaFileAppend("data/scripts/biome_map.lua", dir.."scripts/append_biome_map.lua")
ModLuaFileAppend("mods/noita.hardmod/files/modules/biome_map/biome_map.lua", dir.."scripts/append_biome_map.lua")

utils.AddEnemyToProgress("hardmod_fungal_longleg", "longleg")

for xml in nxml.edit_file("data/biome/_biomes_all.xml") do
	for _,alt_biome in ipairs(alt_biomes) do
		xml:add_child(nxml.new_element("Biome", {
			biome_filename = table.concat({dir,"biomes/",alt_biome.biome,".xml"}),
			height_index = "1",
			color = ("%x"):format(alt_biome.colour_id),
		}))
		print(("%x"):format(alt_biome.colour_id))
	end
end