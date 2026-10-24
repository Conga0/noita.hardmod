local lootlib = dofile_once("mods/noita.hardmod/lib/lootlib.lua")---@type lootlib

lootlib.on_chest_pre_open(function (ctx, tbl, tname)
  local extra_rolls = tonumber(GlobalsGetValue("hardmod_better_chests_stacks")) or 0

  if tname == "chest_random_super" then
    extra_rolls = extra_rolls + 4
  elseif tname == "chest_random" then
    extra_rolls = extra_rolls + 1
  end

  ctx.vars.rolls = ctx.vars.rolls + extra_rolls
end)
