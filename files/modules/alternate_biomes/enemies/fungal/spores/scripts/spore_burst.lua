dofile_once("data/scripts/lib/utilities.lua")

local spore_file = "mods/noita.hardmod/files/modules/alternate_biomes/enemies/fungal/spores/spore.xml"

function spore_count(entity_id, default)
	local storage = EntityGetFirstComponent(entity_id, "VariableStorageComponent", "spore_count")
	if storage then return ComponentGetValue2(storage, "value_int") end
	return default
end

local function blocked(x, y, dx, dy, dist)
	return (RaytraceSurfaces(x, y, x + dx * dist, y + dy * dist))
end

local function open_point(x, y)
	local nx, ny = 0, 0
	for i = 0, 7 do
		local a = i * math.pi / 4
		local dx, dy = math.cos(a), math.sin(a)
		if not blocked(x, y, dx, dy, 6) then
			nx = nx + dx
			ny = ny + dy
		end
	end
	local len = math.sqrt(nx * nx + ny * ny)
	if len < 0.01 then return x, y end
	return x + nx / len * 3, y + ny / len * 3
end

function spore_burst(shooter, x, y, count)
	SetRandomSeed(x + GameGetFrameNum(), y + shooter)
	x, y = open_point(x, y)
	local offset = Random(0, 628) * 0.01
	for i = 1, count do
		local angle = offset + (i / count) * math.pi * 2 + Random(-25, 25) * 0.01
		local dx, dy = math.cos(angle), math.sin(angle)
		if blocked(x, y, dx, dy, 6) then
			dx = -dx
			dy = -dy
		end
		local spore = EntityLoad(spore_file, x, y)
		GameShootProjectile(shooter, x, y, x + dx * 100, y + dy * 100, spore, false)
	end
end
