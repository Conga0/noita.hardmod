local eid = GetUpdatedEntityID()
local x, y = EntityGetTransform(eid)

-- idk how else to ensure the book gets fucking spawned this is so fucking annoying
local player = EntityGetInRadiusWithTag(x, y, 300, "player_unit")
if player and #player > 0 then
  print("spawning house")

  EntityLoad("data/entities/props/furniture_bed.xml", x - 36, y - 8)
  EntityLoad("data/entities/props/furniture_wood_table.xml", x + 41, y - 8)
  EntityLoad("mods/noita.hardmod/files/modules/vanilla_perk_rebalances/entities/items/cheese.xml", x + 34, y - 20)
  EntityLoad("mods/noita.hardmod/files/modules/biome_map/biome/cheese/book.xml", x, y - 20)

  EntityKill(eid)
end
