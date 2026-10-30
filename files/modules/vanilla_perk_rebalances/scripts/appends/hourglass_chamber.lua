RegisterSpawnFunction(0xff5cf5f5, "spawn_extra_items_outer")
RegisterSpawnFunction(0xff5cffff, "spawn_extra_items_inner")
-- RegisterSpawnFunction(0xff14eded, "spawn_extra_items_innerer")
RegisterSpawnFunction(0xff43dcdc, "spawn_extra_items_middle")

local function get_extra_item_count()
  local count = tonumber(GlobalsGetValue("TEMPLE_SHOP_ITEM_COUNT")) or 5
  return count - 5
end

function init(x, y)
  LoadPixelScene(
    "mods/noita.hardmod/files/modules/vanilla_perk_rebalances/gfx/hourglass_chamber.png",
    "", x, y, "data/biome_impl/snowcastle/hourglass_chamber_background.png", true
  )
end

function spawn_extra_items_outer(x, y)
  if get_extra_item_count() >= 2 then spawn_items(x, y) end
end

function spawn_extra_items_inner(x, y)
  if get_extra_item_count() >= 4 then spawn_items(x, y) end
end

-- function spawn_extra_items_innerer(x, y)
--   if get_extra_item_count() >= 6 then spawn_items(x, y) end
-- end

function spawn_extra_items_middle(x, y)
  local count = get_extra_item_count()
  if count == 1 or count == 3 or count >= 5 then
    spawn_items(x, y)
  end
end
