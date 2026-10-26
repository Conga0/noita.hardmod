dofile_once("mods/noita.hardmod/lib/utilities.lua")

local base = "data/biome_impl/temple/"
local base_custom = "mods/noita.hardmod/files/modules/trappier_traps/portal_basin/"
local default_material = base.."altar_top.png"

local basin_materials = {
  { weight = 15, file = default_material },

  { weight = 5, file = base.."altar_top_lava.png" },
  { weight = 4, file = base_custom.."altar_top_poly.png" },
  { weight = 4, file = base_custom.."altar_top_chaotic_poly.png" },

  { weight = 3, file = base.."altar_top_radioactive.png" },
  { weight = 3, file = base.."altar_top_oil.png" },

  { weight = 2, file = base.."altar_top_water.png" },
  { weight = 2, file = base.."altar_top_blood.png" },
}

local evil_hms = {
  { 900, 1500 },
  { 2400, 3000 },
  { 4400, 5100 },
  { 6000, 6700 },
  { 8000, 8700 },
}

local function get_material(x, y)
  if y > 12000 then return base.."altar_top_boss_arena.png" end

  SetRandomSeed(666, 666)
  local evil = Random(1, 15)
  if evil <= #evil_hms then
    local hm = evil_hms[evil]
    if y >= hm[1] and y <= hm[2] then
      return base.."altar_top_lava.png"
    end
  end

  SetRandomSeed(x, y)
  return RandomFromTable(basin_materials).file
end

function spawn_altar_top(x, y, is_solid)
  LoadBackgroundSprite("data/biome_impl/temple/wall_background.png", x-1, y - 30, 35)

  local material = get_material(x, y)

  LoadPixelScene(material, base.."altar_top_visual.png", x, y-40, "", true, false, {
    ["fff18beb"] = "magic_liquid_polymorph",
    ["ff91448d"] = "magic_liquid_random_polymorph",
  })

  if is_solid then
    LoadPixelScene("data/biome_impl/temple/solid.png", "", x, y-40+300, "", true)
  end
end
