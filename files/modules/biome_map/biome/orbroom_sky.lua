CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")

RegisterSpawnFunction(0xffffeedd, "init")

function spawn_small_enemies() end
function spawn_big_enemies() end
function spawn_items() end
function spawn_props() end
function spawn_props2() end
function spawn_props3() end
function spawn_lamp() end
function load_pixel_scene() end
function load_pixel_scene2() end
function spawn_unique_enemy() end
function spawn_unique_enemy2() end
function spawn_unique_enemy3() end
function spawn_ghostlamp() end
function spawn_candles() end
function spawn_potions() end
function spawn_wands() end

function init(x, y)
	LoadPixelScene(
		"mods/noita.hardmod/files/modules/biome_map/gfx/orbroom_sky.png",
		"mods/noita.hardmod/files/modules/biome_map/gfx/orbroom_sky_visual.png",
		x, y,
		"mods/noita.hardmod/files/modules/biome_map/gfx/orbroom_sky_background.png",
		true
	)
end

function spawn_orb(x, y)
	EntityLoad("data/entities/items/orbs/orb_01.xml", x, y)
	EntityLoad("data/entities/misc/music_energy_000.xml", x, y - 10)
	EntityLoad("data/entities/particles/blue_dust.xml", x, y)

	EntityLoad("mods/noita.hardmod/files/modules/biome_map/entity/book_sky_orb.xml", x - 30, y + 40)
end
