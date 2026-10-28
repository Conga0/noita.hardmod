-- is this too much effort for a joke

CHEST_LEVEL = 0
RegisterSpawnFunction(0xffffeedd, "init")

function init(x, y)
  local hx = x + 60
  local hy = y + 544

  EntityLoad("data/entities/buildings/safe_haven_building.xml", hx, hy)
  -- EntityLoad("data/entities/props/physics/lantern_small.xml", pos_x - 1, pos_y - 32)
	EntityLoad("data/entities/props/furniture_bed.xml", hx - 36, hy - 8)
	EntityLoad("data/entities/props/furniture_wood_table.xml", hx + 41, hy - 8)
	EntityLoad("mods/noita.hardmod/files/modules/biome_map/biome/cheese/book.xml", hx, hy - 20)

  LoadPixelScene("mods/noita.hardmod/files/modules/biome_map/gfx/cheese_room.png", "", x, y, "", true)
end
