local ng_offset = 1

local hellmode_ng_offset = 1
local hellmode_air_mult = 0.8

local function entry_can_spawn(tbl, entry, x, y)
	if type(entry) ~= "table" or not entry.prob then return false end

	if entry.spawn_check and not entry.spawn_check() then
		return false
	end

	if entry.ngpluslevel and (tbl.ng_level + ng_offset) < entry.ngpluslevel and tbl.pw_x == 0 then
		return false
	end

	if entry.parallel and tbl.pw_x == 0 then
		return false
	end

	return true
end

local function init_total_prob_enemies(tbl, x, y)
	local ng = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) or 0
	local pw = GetParallelWorldPosition(x, 0)
	local is_hellmode = GameHasFlagRun("hardmod_hell")

	if is_hellmode then
		ng = ng + hellmode_ng_offset

		-- todo: idk if thats evil
		if
			(tbl == g_small_enemies or tbl == g_big_enemies)
			and type(tbl[1]) == "table" and tbl[1].entity == ""
		then
			tbl[1].prob = tbl[1].prob * hellmode_air_mult
		end
	end

	if tbl.total_prob and tbl.total_prob ~= 0 and tbl.ng_level == ng and tbl.pw_x == pw then
		return
	end

	tbl.total_prob = 0
	tbl.ng_level = ng
	tbl.pw_x = pw

	for _,entry in pairs(tbl) do
		if entry_can_spawn(tbl, entry, x, y) then
			tbl.total_prob = tbl.total_prob + entry.prob
		end
	end
end

-- This seems to only get called for spawning enemies
function random_from_table(tbl, x, y)
	init_total_prob_enemies(tbl, x, y)
	local rnd = ProceduralRandom(x, y) * tbl.total_prob

	for _,entry in pairs(tbl) do
		if entry_can_spawn(tbl, entry, x, y) then
			if rnd <= entry.prob then return entry end
			rnd = rnd - entry.prob
		end
	end

	return nil
end
