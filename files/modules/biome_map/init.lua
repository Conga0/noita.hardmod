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

-- todo: this might belong to a different module but i cba to figure it out rn
for file in nxml.edit_file("data/entities/misc/rock_curse.xml") do
  local comp = file:first_of("AreaDamageComponent")
  if comp then
    comp:set("aabb_min.x", -257)
    comp:set("aabb_min.y", -257)
    comp:set("aabb_max.x", 257)
    comp:set("aabb_max.y", 257)
  end
end

return {}
