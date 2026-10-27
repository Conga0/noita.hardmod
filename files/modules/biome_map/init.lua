local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua")---@type nxml

ModMagicNumbersFileAdd("mods/noita.hardmod/files/modules/biome_map/magic_numbers.xml")

local custom_biomes = {
  { h = 2, color = "ffde88e3", file = "secret_lab_path.xml" },
  { h = 0, color = "ffff56a5", file = "pw_barrier.xml" },
  { h = 0, color = "ffffe098", file = "cheese.xml" },
}

for file in nxml.edit_file("data/biome/_biomes_all.xml") do
  for _,biome in pairs(custom_biomes) do
    file:create_child("Biome", {
      biome_filename = "mods/noita.hardmod/files/modules/biome_map/biome/" .. biome.file,
      height_index = biome.h,
      color = biome.color
    })
  end
end

modifile(
  "data/scripts/biomes/snowcastle_cavern.lua",
  [[local is_right = ]],
  [[local is_right = true --]]
)

return {}
