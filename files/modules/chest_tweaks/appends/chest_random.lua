local lootlib = dofile_once("mods/noita.hardmod/lib/lootlib.lua")---@class lootlib

function on_open(entity)
	local x, y = EntityGetTransform(entity)

  local rx = x
	local ry = y

	local pos = EntityGetFirstComponent(entity, "PositionSeedComponent")
	if pos then
		rx = tonumber(ComponentGetValue2(pos, "pos_x")) or rx
		ry = tonumber(ComponentGetValue2(pos, "pos_y")) or ry
	end

  rx = rx + 509.7
	ry = ry + 683.1

	SetRandomSeed(rx, ry)

  local ctx = lootlib.create_context(x, y, rx, ry, entity, 2)
  local loot_table = lootlib.get_loot_table("chest_random")

  lootlib.generate(loot_table, ctx)

	if ctx.vars.bad_rolls > 0 then
		EntityLoad("data/entities/particles/image_emitters/chest_effect_bad.xml", x, y)
	else
		EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
	end
end
