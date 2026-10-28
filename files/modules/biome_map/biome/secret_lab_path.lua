CHEST_LEVEL = 0

RegisterSpawnFunction(0xffffeedd, "init")
RegisterSpawnFunction(0xff00ff2e, "spawn_book")

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

function spawn_book(x, y)
  -- TODO: i might add a lore book or something
  -- EntityLoad("", x, y)
end

function init(x, y)
  LoadPixelScene("mods/noita.hardmod/files/modules/biome_map/gfx/secret_lab_path.png", "", x, y, "", true)
end
