local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua")---@type nxml

local function patch_spawn_rules()
  local patch_biomes = {
    "coalmine_alt",
    "crypt",
    "excavationsite",
    "fungicave",
    "snowcastle",
    "snowcave",
    "vault",
  }

  for _,biome in pairs(patch_biomes) do
    ModLuaFileAppend(
      "data/scripts/biomes/" .. biome .. ".lua",
      "mods/noita.hardmod/files/modules/stronger_enemies/biomes/" .. biome .. ".lua"
    )
  end

  ModLuaFileAppend("data/scripts/director_helpers.lua", "mods/noita.hardmod/files/modules/stronger_enemies/appends/director_helpers.lua")
end

local function patch_less_annoying_blinding()
  -- This does make the blinding effect easier, but patch_spawn_rules adds more blinding mages
  -- (in e.g. collapsed mines and coal pits) so i think that's a fair tweak

  -- 20s -> 12s
  for file in nxml.edit_file("data/entities/misc/effect_blindness.xml") do
    local effect = file:first_of("GameEffectComponent")
    if effect then
      effect:set("frames", 720)
    end
  end

  -- you can see more, but the visible area is darker
  modifile(
    "data/shaders/post_final.frag",
    [[overlay_color_blindness.a * edge_dist*edge_dist * 40.0]],
    [[overlay_color_blindness.a * edge_dist*edge_dist * 2.0]]
  )
end

patch_spawn_rules()
patch_less_annoying_blinding()

-- todo
--[[
  {
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/barfer.xml"
	},
]]

return {}
