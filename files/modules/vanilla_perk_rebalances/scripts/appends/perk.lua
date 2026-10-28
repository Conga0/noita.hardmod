local no_early_perks = {
  ["HARDMOD_ITEM_IMMUNITIES"] = true,
}

-- does not include potential "Extra Perk", but that's fine
local early_perk_count = 6 -- two HMs
local early_reroll_count = 3 * 4 -- 4 rerolls (800 gold)

local function table_move(tbl, idx_from, idx_to)
  if idx_from > #tbl or idx_to > #tbl or idx_to < 1 then
    error("Invalid index passed to table_move")
  end

  local item = table.remove(tbl, idx_from)
  if item ~= nil then table.insert(tbl, idx_to, item) end
end

local orig_perk_get_spawn_order = perk_get_spawn_order
function perk_get_spawn_order(arg)
  local tbl = orig_perk_get_spawn_order(arg)
  if not tbl or #tbl < 50 then return tbl end

  for idx=1,early_perk_count do
    while no_early_perks[tbl[idx]] do
      table_move(tbl, idx, idx + early_perk_count)
    end
  end

  local last_early_idx = #tbl - early_reroll_count + 1

  for idx=#tbl,last_early_idx,-1 do
    while no_early_perks[tbl[idx]] do
      table_move(tbl, idx, idx - early_reroll_count)
    end
  end

  return tbl
end
