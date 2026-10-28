-- is this too much effort for a joke

CHEST_LEVEL = 0
RegisterSpawnFunction(0xffffeedd, "init")

function spawn_small_enemies(x, y) end
function spawn_big_enemies(x, y) end
function spawn_items(x, y) end
function spawn_props(x, y) end
function spawn_props2(x, y) end
function spawn_props3(x, y) end
function spawn_lamp(x, y) end
function load_pixel_scene(x, y) end
function load_pixel_scene2(x, y) end
function spawn_unique_enemy(x, y) end
function spawn_unique_enemy2(x, y) end
function spawn_unique_enemy3(x, y) end
function spawn_ghostlamp(x, y) end
function spawn_candles(x, y) end
function spawn_potions(x, y) end
function spawn_wands(x, y) end

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
