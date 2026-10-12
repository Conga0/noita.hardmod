dofile_once("mods/noita.hardmod/lib/utilities.lua")
local img = dofile_once("mods/noita.hardmod/lib/image_utils.lua")

local hooks = {}
local path = "mods/noita.hardmod/files/modules/holy_mountain_rework/"
local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

ModMaterialsFileAdd(path.."materials.xml")

local move_targets = {
	["data/biome_impl/temple/altar_snowcave_capsule.png"] = true,
	["data/biome_impl/temple/altar_snowcastle_capsule.png"] = true,
	["data/biome_impl/temple/altar_vault_capsule.png"] = true,
}
for xml in nxml.edit_file("data/biome/_pixel_scenes.xml") do
	for child in xml:first_of("mBufferedPixelScenes"):each_child() do
		if move_targets[child.attr.material_filename] then
			child.attr.pos_x = child.attr.pos_x - 44
		end
	end
end


local visual_references = {
	"data/scripts/biomes/temple_altar_right_empty.lua",
	"data/scripts/biomes/temple_altar_right_snowcastle_empty.lua",
	"data/scripts/biomes/temple_altar_right_snowcastle.lua",
	"data/scripts/biomes/temple_altar_right_snowcave_empty.lua",
	"data/scripts/biomes/temple_altar_right_snowcave.lua",
	"data/scripts/biomes/temple_altar_right.lua",
}

local visual_path = path.."images/visual.png"
local bg_path = path.."images/background.png"
local append_path = path.."append_right_altar.lua"
for _,file in ipairs(visual_references) do
	modifile(file, [[data/biome_impl/temple/altar_right_visual.png]], visual_path)
	modifile(file, [[data/biome_impl/temple/altar_right_background.png]], bg_path)
	ModLuaFileAppend(file, append_path)
end
img.ImageOverlay("data/biome_impl/temple/altar_right.png", path.."images/material.png", 0, 8)
img.ImageOverlay("data/biome_impl/temple/altar_right_snowcastle.png", path.."images/material_flat_exit.png", 0, 8)

modifile("data/scripts/perks/perk.lua",
		[[if( Random( 1, 100 ) <= perk_destroy_chance ) then]],
		[[if( Random( 1, 100 ) <= perk_destroy_chance ) then dofile("mods/noita.hardmod/files/modules/holy_mountain_rework/perk_disappear_hook.lua")(pos_x, pos_y);]]
)
ModLuaFileAppend("data/scripts/biomes/temple_altar.lua", path.."append_altar.lua")

return hooks