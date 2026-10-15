dofile_once("mods/noita.hardmod/lib/utilities.lua")

local hooks = {}
local directory = "mods/noita.hardmod/files/modules/nerf_vanilla_cheeses/"
local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml


-- Nerf Stevari and Skoude to be 95% resistant to Physics Damage
local reduce_physics_damage = {
	"data/entities/animals/necromancer_shop.xml",
	"data/entities/animals/necromancer_super.xml",
	"data/entities/animals/necromancer.xml",
}
for _,path in ipairs(reduce_physics_damage) do
	for xml in nxml.edit_file(path) do
		local dmc = xml:first_of("DamageModelComponent")
		if dmc then
			local mults = dmc:first_of("damage_multipliers")
			if mults then mults.attr.physics_hit = "0.05" end
		end
	end
end


-- Nerf Tannerkivi to not work on Extremely Dense Rock
function hooks.edit_material(elem)
    local mat_name = elem.attr.name
    if mat_name == "rock_hard_border" or mat_name == "rock_hard" then
        elem.attr.tags = elem.attr.tags:gsub(escape(",[earth]"), "")
    end
end


return hooks