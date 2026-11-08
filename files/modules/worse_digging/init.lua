local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml
local deck = "data/entities/projectiles/deck/"

local hooks = {}

local lasers = {
	"orb_laseremitter_four.xml",
	"orb_laseremitter_cutter.xml",
}

for _,proj in pairs(lasers) do
  for file in nxml.edit_file(deck..proj) do
    for emitter in file:each_of("LaserEmitterComponent") do
      local laser = emitter:first_of("laser")
      if laser then
        laser:set("max_cell_durability_to_destroy", 11)
      end
    end
  end
end

for file in nxml.edit_file(deck.."luminous_drill.xml") do
	local pcomp = file:first_of("ProjectileComponent")
	if pcomp then
		pcomp:set("ground_penetration_max_durability_to_destroy", 11)
	end
end

-- matter eaten't
local matter_eatent_list = {
	rock_hard_border = true,
	templebrick_static = true,
	templebrick_noedge_static = true,
}

function hooks.edit_material(mat)
	local name = mat.attr.name

	if matter_eatent_list[name] then
		local tags = mat.attr.tags
		tags = tags and (tags .. ",") or ""
		mat.attr.tags = tags .. "[matter_eater_ignore_list]"
	end
end

return hooks
